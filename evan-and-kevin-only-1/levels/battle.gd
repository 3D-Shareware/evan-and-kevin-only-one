extends Node2D

enum elements {none, ice, fire, water, plant, earth, light, plague}

signal advanceText

@onready var element_displays = [$"Player Element", $"Enemy Element"]
@onready var name_displays = [$"Player Element/Player Creature Text", $"Enemy Element/Enemy Creature Text"]
@onready var stat_displays = [$"Player Element/Player Stats/Stat Text", $"Enemy Element/Enemy Stats/Stat Text"]
@onready var battle_text = $"Battle Text"
@onready var move_element = $"Move Element"
@onready var anim = $"Camera2D/Camera Animator"
@onready var health_bars = [$"Player Health", $"Enemy Health"]

const TEAM_TEXT_OFFSETS = ["[left]", "[right]", "Your", "Enemy", "[color=#ff1717]", "[color=#fff700]"]

# normally empty array, but can set to test scenarios
var teams = [
	[AlchemouseCreature.new(), FeyereCreature.new()],
	[RockstrichCreature.new(), ShriekadeeCreature.new()]
]

# var all_creatures = [
	# PeepsicleCreature.new(), FeyereCreature.new(), SuperNovaCreature.new(), QuakenCreature.new(),
	# TimboarCreature.new(), SturglockCreature.new(), ResentanaCreature.new(), ShriekadeeCreature.new(),
	# BrinotaurCreature.new(), WatchearthCreature.new(), GouroborosCreature.new(), IceopodCreature.new(),
	# RockstrichCreature.new(), AlchemouseCreature.new()
# ]

var busy = false # set to true when handling damage and not able to select a move

var readied_moves = []

var rng = RandomNumberGenerator.new()

func debug_stat_test():
	var stats = [0, 0, 0]
	for i in []:#all_creatures:
		add_child(i)
		stats[0] += i.base_health
		stats[1] += i.base_power
		stats[2] += i.base_speed
	print("Total health: " + str(stats[0]))
	print("Total power: " + str(stats[1]))
	print("Total speed: " + str(stats[2]))

func _ready():
	# debug_stat_test()
	for i in teams[0]:
		add_child(i)
		i.position.x = -256
		i.team = 0
		i.sprite.offset.x = -512
		i.hide()
	for i in teams[1]:
		add_child(i)
		i.position.x = 256
		i.team = 1
		i.sprite.offset.x = 512
		i.sprite.flip_h = true
		i.hide()
	teams[0][0].show()
	teams[0][0].animate_spawn()
	teams[1][0].show()
	teams[1][0].animate_spawn()
	update_names_and_stats()
	display_moves()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_reset"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("debug_space"):
		activate_moves()

func display_moves():
	battle_text.text = "Bust a move!"
	describe_move(teams[0][0].moveset[0])
	move_element.show()

func describe_move(move: BaseMove):
	if move.element_id in teams[1][0].weaknesses:
		battle_text.text = "\t\t" + move.move_name + " | Power: " + str(move.damage) + "% | Speed: " + str(move.action_speed) + "% | Accuracy: " + str(move.accuracy) + "%" + " | [color=#fff700]Super effective[/color]\n\t\t" + move.descr
	else:
		battle_text.text = "\t\t" + move.move_name + " | Power: " + str(move.damage) + "% | Speed: " + str(move.action_speed) + "% | Accuracy: " + str(move.accuracy) + "%" + "\n\t\t" + move.descr
	move_element.frame = move.element_id

func activate_moves():
	if !busy:
		busy = true
		if !readied_moves:
			readied_moves = [teams[0][0].moveset[0], teams[1][0].moveset[0]]
		# compare speeds to determine who goes first
		var turn_order: Array # [0 for player, 1 for foe]
		if readied_moves[0].action_speed * teams[0][0].speed >= readied_moves[1].action_speed * teams[1][0].speed:
			turn_order = [0, 1]
		else:
			turn_order = [1, 0]
		
		move_element.hide()
		
		for i in 2:
			if teams[turn_order[i]][0].alive:
				battle_text.text = teams[turn_order[i]][0].display_name + " used " + readied_moves[turn_order[i]].move_name + "!"
				await advanceText
				use_move(readied_moves[turn_order[i]], turn_order[i])
				await advanceText
		
			for j in 2:
				if teams[j][0].time_to_die():
					battle_text.text = TEAM_TEXT_OFFSETS[j + 4] + teams[j][0].display_name + " has fallen![/color]"
					await advanceText
		
		busy = false
		display_moves()

func use_move(move: BaseMove, user: int):
	if move.deals_damage:
		if rng.randf_range(0, 100) > move.accuracy:
			# move misses!
			battle_text.text += "\n[color=#ff1717]But it missed![/color]"
			teams[user][0].animate_move("Miss")
		else:
			if move.element_id in teams[1 - user][0].weaknesses:
				battle_text.text += "\n[color=#fff700]" + str(int(teams[1 - user][0].take_damage(0.01 * 1.5 * move.damage * teams[user][0].power))) + " damage![/color]"
			else:
				battle_text.text += "\n" + str(int(teams[1 - user][0].take_damage(0.01 * move.damage * teams[user][0].power))) + " damage!"
			battle_text.text += " " + move.on_hit(teams[user][0], teams[1 - user][0])
			teams[user][0].animate_move(move.move_animation)
	update_names_and_stats()

func update_names_and_stats():
	for i in 2:
		element_displays[i].frame = teams[i][0].element_id
		name_displays[i].text = TEAM_TEXT_OFFSETS[i] + teams[i][0].display_name
		stat_displays[i].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].speed)) + "\n" + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].health)) + "/" + str(int(teams[i][0].max_health))
		# stat_displays[i].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].health)) + "/" + str(int(teams[i][0].max_health)) + "\n" + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed))
		health_bars[i].max_value = teams[i][0].max_health
		health_bars[i].value = teams[i][0].health
		health_bars[i].tint_progress = Color.from_hsv(0.35 * (health_bars[i].value / health_bars[i].max_value), 1.0, 1.0)

func _input(event):
	if event.is_action_pressed("advance_text"):
		advanceText.emit()

func play_camera_anim(anim_name: String):
	anim.stop()
	anim.play(anim_name)
