class_name BaseCreature extends Node2D

## none, ice, fire, water, plant, earth, light, plague
enum elements {none, ice, fire, water, plant, earth, light, plague}

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
var team: int # 0 for player, 1 for foe

## Determines stat multipliers. Lv. 1 is a creatue with no talisman. Goes up to Lv. 4, increasing stats by 20% for every level over 1.
var level: int


func _ready():
	ready_element()
	ready_creature()
	add_child(load("res://objects/misc/creature_sprite.tscn").instantiate())
	sprite = get_node("Creature Sprite")
	anim = get_node("Creature Sprite/Battle Animator")
	hue_anim = get_node("Creature Sprite/Hue Animator")
	alive = true
	sprite.texture = sprite_path
	max_health = 200 + 3 * base_health # * (1 + ((level - 1) * 0.2))
	health = max_health
	power = 50 + base_power # * (1 + ((level - 1) * 0.2))
	speed = 50 + base_speed # * (1 + ((level - 1) * 0.2))
	moveset = guaranteed_moves.duplicate(true)
	for i in extra_moves:
		moveset.append(i)
	for i in moveset.size():
		moveset[i] = moveset[i].new()
	# print_moves()

func ready_element():
	pass # overriden by children

func ready_creature():
	pass # overriden by children

func print_moves():
	print("My moves:")
	for i in moveset:
		print(i.move_name)
		# print(i.move_name)

func take_damage(dmg: int) -> int:
	hue_anim.stop()
	hue_anim.play("takeDamage")
	dmg += 1 # ensures you always take 1 damage
	health = max(health - dmg, 0)
	armor = max(armor - dmg, 0)
	return dmg

func animate_spawn():
	anim.stop()
	anim.play("spawn" + spawn_anim + str(team))

func animate_move(anim_name: String):
	anim.stop()
	anim.play("attack" + anim_name + str(team))

func perish():
	anim.stop()
	anim.play("perish" + str(team))

func time_to_die() -> bool:
	if alive and health <= 0 and armor <= 0:
		alive = false
		perish()
		return true # returns true if it just got killed
	return false # otherwise ya didn't do anything

func weak_to_type(element: String) -> bool: # returns true if weak, false otherwise
	if element in weaknesses:
		return true
	return false
