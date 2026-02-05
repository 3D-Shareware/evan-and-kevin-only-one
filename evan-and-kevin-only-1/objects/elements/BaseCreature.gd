class_name BaseCreature extends Node2D

enum elements {none, ice, fire, water, plant, earth, light, plague, ether}

var sprite: Node
var anim: Node
var hue_anim: Node

# these are set by element
var element_id: int
var weaknesses: Array

# individual creatures set these
## Name displayed to player.
var display_name: String
## Path to the sprite asset of the creature.
var sprite_path: Resource
## Dash, Heavy, Bounce, Rise, Teleport
var spawn_anim: String
## Description of creature in the dex.
var descr: String
## Stat that determines health.
var base_health: int
## Stat that determines damage dealt by its attacks.
var base_power: int
## Stat that determines speed. Faster creature moves first.
var base_speed: int
## Creature will always spawn with the moves provided here.
var guaranteed_moves: Array 
## Creature fills the rest of its moveset with random choices from this list.
var extra_moves: Array

# these are handled by this class!
var max_health: int
var health: int
var max_armor: int # armor stats only used if they are set to something
var armor: int
var power: int
var speed: int
var moveset: Array
var alive: bool
var invincible: bool
var team: int # 0 for player, 1 for foe
## When set before the creature is summoned, they have a talisman locked to them. Set to the talisman attached to the creature.
var bound_talisman: BaseTalisman

## Determines stat multipliers. Lv. 1 is a creatue with no talisman. Increases stats by 10% for every level over 1.
var level: int

## Set to true for The Only One.
var boss: bool

## Used to determine what moves AI should use.
var turns_alive: int

func _init() -> void: # was _ready()
	boss = false
	ready_creature()
	ready_element()
	add_child(load("res://objects/misc/creature_sprite.tscn").instantiate())
	sprite = get_node("Creature Sprite")
	anim = get_node("Creature Sprite/Battle Animator")
	hue_anim = get_node("Creature Sprite/Hue Animator")
	sprite.texture = sprite_path
	ready_rest_of_creature()
	# print_moves()

func ready_rest_of_creature():
	turns_alive = 0
	alive = true
	invincible = false
	moveset = guaranteed_moves.duplicate(true)
	while moveset.size() < 6:
		if extra_moves.size() > 0:
			var random_move_id = randi_range(0, extra_moves.size() - 1)
			moveset.append(extra_moves[random_move_id])
			extra_moves.pop_at(random_move_id)
		else:
			break
	for i in moveset.size():
		moveset[i] = moveset[i].new()
	if boss:
		level_up(level)
	elif bound_talisman:
		level_up(bound_talisman.level)
	else:
		level_up(1)

func ready_element():
	pass # overriden by children

func ready_creature():
	pass # overriden by children

func level_up(new_lvl: int):
	level = new_lvl
	reset_stats()

func print_moves():
	print("My moves:")
	for i in moveset:
		print(i.move_name)
		# print(i.move_name)

func reset_stats():
	armor = 0
	max_armor = 0
	max_health = 200 + 3 * base_health # * (1 + ((level - 1) * 0.2))
	health = max_health
	power = 50 + base_power # * (1 + ((level - 1) * 0.2))
	speed = 50 + base_speed # * (1 + ((level - 1) * 0.2))
	@warning_ignore("narrowing_conversion")
	max_health += max_health * (level - 1) * 0.15
	health = max_health
	@warning_ignore("narrowing_conversion")
	power += power * (level - 1) * 0.15
	@warning_ignore("narrowing_conversion")
	speed += speed * (level - 1) * 0.15

func take_damage(dmg: int, hits_armor: bool) -> int:
	if !invincible:
		hue_anim.stop()
		hue_anim.play("takeDamage")
		dmg += 1 # ensures you always take 1 damage
		var battle_properties = get_parent().battle_properties
		for i in battle_properties[team]:
			if i.display_name == "Sapped" and !max_armor:
				if weak_to_type(elements["plant"]):
					get_parent().teams[1 - team][0].heal_damage(dmg * 0.5)
				else:
					get_parent().teams[1 - team][0].heal_damage(dmg * 0.25)
			if i.display_name == "Tortured":
				if weak_to_type(elements["plague"]):
					@warning_ignore("narrowing_conversion")
					dmg += max_health * 0.1
				else:
					@warning_ignore("narrowing_conversion")
					dmg += max_health * 0.05
		health = max(health - dmg, 0)
		if hits_armor:
			armor = max(armor - dmg, 0)
		return dmg
	return 0

func heal_damage(dmg: int) -> int:
	if boss:
		@warning_ignore("narrowing_conversion")
		dmg *= 0.5
	if !invincible:
		var battle_properties = get_parent().battle_properties
		for i in battle_properties[team]:
			if i.display_name == "Grounded" and !max_armor:
				if weak_to_type(elements["earth"]):
					take_damage(dmg, false)
					return 0
				else:
					return 0
		if health:
			var old_health = health
			health = min(max_health, health + dmg)
			return health - old_health
		return 0
	return 0

func animate_spawn():
	anim.stop()
	anim.play("spawn" + spawn_anim + str(team))

func animate_move(anim_name: String):
	anim.stop()
	anim.play("attack" + anim_name + str(team))

func perish():
	if boss:
		anim.stop()
		anim.play("bossDeath" + str(team))
	else:
		anim.stop()
		anim.play("perish" + str(team))

func time_to_die(battle_properties: Array) -> bool:
	if alive and health <= 0 and armor <= 0:
		for i in battle_properties[team]:
			if i.display_name == "Anchored":
				return false
		alive = false
		perish()
		return true # returns true if it just got killed
	return false # otherwise ya didn't do anything

func weak_to_type(element: int) -> bool: # returns true if weak, false otherwise
	if element in weaknesses:
		return true
	return false

func apply_status(status: BaseStatus, battle_properties: Array) -> bool:
	if status.is_terrain:
		for i in battle_properties[team]:
			if i.display_name == "Safety Bubble":
				return false # you're protected!
	if status.element_id and element_id == status.element_id:
		return false # you're immune!
	else:
		for i in battle_properties[team]:
			if i.display_name == status.display_name:
				return false
		battle_properties[team].append(status)
		# status.on_apply(self)
		return true
