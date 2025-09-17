extends Node2D

enum elements {none, ice, fire, water, plant, earth, light, plague}
enum button_types {moves, talismans, summons}

signal advanceText

@onready var element_displays = [$"Player Element", $"Enemy Element"]
@onready var name_displays = [$"Player Element/Player Creature Text", $"Enemy Element/Enemy Creature Text"]
@onready var stat_displays = [$"Player Element/Player Stats/Stat Text", $"Enemy Element/Enemy Stats/Stat Text", $"Player Element/Player Stats", $"Enemy Element/Enemy Stats"]
@onready var battle_text = $"Battle Text"
@onready var move_element = $"Move Element"
@onready var anim = $"Camera2D/Camera Animator"
@onready var health_bars = [$"Player Health", $"Enemy Health"]

const TEAM_TEXT_OFFSETS = ["[left]", "[right]", "Your", "Enemy", "[color=#ff1717]", "[color=#fff700]"]

# normally empty array, but can set to test scenarios
var teams = [
	[RockstrichCreature.new(), SmeltynxCreature.new(), AlchemouseCreature.new(), PaladogCreature.new()],
	[PaladogCreature.new(), SturglockCreature.new(), GouroborosCreature.new()]
]

# var all_creatures = [
	# PeepsicleCreature.new(), FeyereCreature.new(), SuperNovaCreature.new(), QuakenCreature.new(),
	# TimboarCreature.new(), SturglockCreature.new(), ResentanaCreature.new(), ShriekadeeCreature.new(),
	# BrinotaurCreature.new(), WatchearthCreature.new(), GouroborosCreature.new(), IceopodCreature.new(),
	# RockstrichCreature.new(), AlchemouseCreature.new(), Paladog.new()
# ]

var battle_buttons = []
var button_type = 1

var busy = false # set to true when handling damage and not able to select a move
var battle_over = false # set to true when battle scene ends
var player_summon_i_offset_bad_bug_fix = 0 # set to 1 after summoning first creature; probably bad-practice bug bix but it's a GameJam so who cares

var readied_moves = []

var battle_properties = [
	[],
	[]
]

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
	for i in 8:
		battle_buttons.append(get_node("Battle Button " + str(i + 1)))
		battle_buttons[i].id = i
		battle_buttons[i].hide()
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
	summon_creature(1, 0)
	# teams[0][0].show()
	# teams[0][0].animate_spawn()
	# teams[1][0].show()
	# teams[1][0].animate_spawn()
	update_names_and_stats()
	display_summons()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_reset"):
		get_tree().reload_current_scene()

func display_moves():
	button_type = button_types["moves"]
	move_element.hide()
	battle_text.text = "Make your move."
	for i in battle_buttons.size():
		if i < teams[0][0].moveset.size():
			var move = teams[0][0].moveset[i]
			if move.element_id in teams[1][0].weaknesses and move.deals_damage:
				battle_buttons[i].set_element_and_text(move.element_id, "[color=#fff700]" + move.move_name + "[/color]")
			else:
				battle_buttons[i].set_element_and_text(move.element_id, move.move_name)
			battle_buttons[i].show()
		else:
			battle_buttons[i].hide()

func display_summons():
	button_type = button_types["summons"]
	move_element.hide()
	battle_text.text = "Summon a creature."
	for i in battle_buttons.size():
		if i < teams[0].size() - player_summon_i_offset_bad_bug_fix:
			var creature = teams[0][i + player_summon_i_offset_bad_bug_fix]
			battle_buttons[i].set_element_and_text(creature.element_id, creature.display_name)
			battle_buttons[i].show()
		else:
			battle_buttons[i].hide()

func describe_button(id: int):
	if button_type == button_types["moves"]:
		var move = teams[0][0].moveset[id]
		if move.element_id in teams[1][0].weaknesses and move.deals_damage:
			battle_text.text = "\t\t" + move.move_name + " | Power: " + str(move.damage) + "% | Speed: " + str(move.action_speed) + "% | Accuracy: " + str(move.accuracy) + "%" + " | [color=#fff700]Advantage! (x1.5 Power)[/color]\n\t\t" + move.descr
		else:
			battle_text.text = "\t\t" + move.move_name + " | Power: " + str(move.damage) + "% | Speed: " + str(move.action_speed) + "% | Accuracy: " + str(move.accuracy) + "%" + "\n\t\t" + move.descr
		move_element.frame = move.element_id
		move_element.show()
	elif button_type == button_types["summons"]:
		var creature = teams[0][id + player_summon_i_offset_bad_bug_fix]
		battle_text.text = "\t\t" + creature.display_name + " | Power: " + str(creature.power) + " | Speed: " + str(creature.speed) + " | Health: " + str(creature.health) + "\n\t\t"
		for i in creature.moveset.size():
			var move = creature.moveset[i]
			if move.element_id in teams[1][0].weaknesses and move.deals_damage:
				battle_text.text += "[color=#fff700]" + move.move_name + "[/color]"
			else:
				battle_text.text += move.move_name
			if i < creature.moveset.size() - 1:
				battle_text.text += " | "
		move_element.frame = creature.element_id
		move_element.show()

func activate_moves():
	if !busy:
		busy = true
		for i in battle_buttons:
			i.hide()
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
		
		readied_moves = []
		for i in 2:
			if battle_properties[i].find("just_lost_ally") != -1:
				battle_properties[i].pop_at(battle_properties[i].find("just_lost_ally"))
		
		# is the foe dead?
		if !teams[1][0].alive:
			# are you FULLY DEAD???
			if !teams[0][0].alive and teams[0].size() <= 1:
				lose_encounter()
			# is the foe FULLY DEAD???
			elif teams[1].size() <= 1:
				win_encounter()
			# foe lost a dude, summons next (you're still alive)
			else:
				battle_properties[1].append("just_lost_ally")
				summon_creature(1, 1)
				battle_text.text = teams[1][0].display_name + " draws near!"
				await advanceText
		# are you dead?
		if !battle_over and !teams[0][0].alive:
			if teams[0].size() <= 1:
				lose_encounter()
			else:
				battle_properties[0].append("just_lost_ally")
				display_summons()
		# returns to move selection otherwise
		elif !battle_over:
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
				battle_text.text += "\n[color=#fff700]" + str(int(teams[1 - user][0].take_damage(0.01 * 1.5 * move.get_damage(teams[user][0], teams[1 - user][0], battle_properties)))) + " damage![/color]"
			else:
				battle_text.text += "\n" + str(int(teams[1 - user][0].take_damage(0.01 * move.get_damage(teams[user][0], teams[1 - user][0], battle_properties)))) + " damage!"
			battle_text.text += " " + move.on_hit(teams[user][0], teams[1 - user][0], battle_properties)
	else:
		battle_text.text += "\n" + move.on_hit(teams[user][0], teams[1 - user][0], battle_properties)
	teams[user][0].animate_move(move.move_animation)
	update_names_and_stats()

func update_names_and_stats():
	for i in 2:
		element_displays[i].frame = teams[i][0].element_id
		name_displays[i].text = TEAM_TEXT_OFFSETS[i] + teams[i][0].display_name
		# stat_displays[i].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].health)) + "/" + str(int(teams[i][0].max_health)) + "\n" + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed))
		if teams[i][0].max_armor:
			stat_displays[i + 2].frame = 1
			stat_displays[i].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed)) + "\n" + str(int(teams[i][0].armor)) + "/" + str(int(teams[i][0].max_armor))
			health_bars[i].max_value = teams[i][0].max_armor
			health_bars[i].value = teams[i][0].armor
			health_bars[i].tint_progress = Color.from_hsv(0.15, 1.0, 1.0)
		else:
			stat_displays[i + 2].frame = 0
			stat_displays[i].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed)) + "\n" + str(int(teams[i][0].health)) + "/" + str(int(teams[i][0].max_health))
			health_bars[i].max_value = teams[i][0].max_health
			health_bars[i].value = teams[i][0].health
			health_bars[i].tint_progress = Color.from_hsv(0.35 * (health_bars[i].value / health_bars[i].max_value), 1.0, 1.0)

func _input(event):
	if event.is_action_pressed("advance_text"):
		advanceText.emit()

func play_camera_anim(anim_name: String):
	anim.stop()
	anim.play(anim_name)

func button_pressed(id: int):
	if button_type == button_types["moves"]:
		readied_moves.append(teams[0][0].moveset[id])
		readied_moves.append(teams[1][0].moveset[0])
		activate_moves()
	elif button_type == button_types["summons"]:
		summon_creature(0, id + player_summon_i_offset_bad_bug_fix)
		busy = false
		display_moves()

func summon_creature(team: int, id: int):
	var creature = teams[team][id]
	if id > 0:
		if player_summon_i_offset_bad_bug_fix:
			teams[team][0] = creature
			teams[team].pop_at(id)
		else:
			teams[team].push_front(creature)
			teams[team].pop_at(id + 1)
	creature.show()
	creature.animate_spawn()
	update_names_and_stats()
	if team == 0:
		player_summon_i_offset_bad_bug_fix = 1

func win_encounter():
	if !battle_over:
		battle_text.text = "[color=#fff700]You survived![/color]"
		battle_over = true

func lose_encounter():
	if !battle_over:
		battle_text.text = "[color=#ff1717]Your journey is over![/color]"
		battle_over = true
