extends Node2D

enum elements {none, ice, fire, water, plant, earth, light, plague, ether}
enum button_types {moves, talismans, summons}
enum scenes {overworld, battle}

signal advanceText
signal doneWithFirstSummon

@onready var element_displays = [$"Player Element", $"Enemy Element"]
@onready var name_displays = [$"Player Element/Player Creature Text", $"Enemy Element/Enemy Creature Text"]
@onready var stat_displays = [[$"Player Element/Stat Text", $"Player Element/Power", $"Player Element/Speed", $"Player Element/Health"],[$"Enemy Element/Stat Text", $"Enemy Element/Power", $"Enemy Element/Speed", $"Enemy Element/Health"]]
@onready var battle_text = $"Battle Text"
@onready var move_element = $"Move Element"
@onready var anim = $"Camera2D/Camera Animator"
@onready var health_bars = [$"Player Element/Player Health", $"Enemy Element/Enemy Health"]
@onready var page_button = $"Page Button"
@onready var advance_text_button = $"Advance Text"
@onready var big_battle_anim = $"AnimationPlayer"

# all this stuff gets set by parent
var difficulty: int
var boss_phases = []
var teams: Array
var talismans: Array
var boss_fight: bool

const TEAM_TEXT_OFFSETS = ["[left]", "[right]", "Your", "Enemy", "[color=#ff1717]", "[color=#fff700]"]

# normally empty array, but can set to test scenarios
# var teams = [
	# [PeepsicleCreature.new(), FeyereCreature.new(), FeyereCreature.new(), SuperNovaCreature.new(), QuakenCreature.new(),
	# TimboarCreature.new(), SturglockCreature.new(), ResentanaCreature.new(), ShrikadeeCreature.new(),
	# BrinotaurCreature.new(), WatchearthCreature.new(), GouroborosCreature.new(), IceopodCreature.new(),
	# RockstrichCreature.new(), AlchemouseCreature.new(), PaladogCreature.new(), SmeltynxCreature.new(),
	# GardeanCreature.new(), JellfireCreature.new(), FlamengoCreature.new(), BlubbitCreature.new(),
	# FamaneCreature.new(), SnowtankCreature.new(), ScubalusCreature.new(), CaongCreature.new(),
	# KitsauroraCreature.new(), DiamondflyCreature.new(), ShinosaurCreature.new(), BamboldCreature.new()],
	# [TheOnlyOne.new()]
# ]

var battle_buttons = []
var status_buttons = [[], []]
var button_type = 1 # 1 for moves, 2 for summons, 3 for talismans
var page = 0 # used to display lots of buttons

var text_should_display = ""

var battle_over = false # set to true when battle scene ends
var first_stat_update = true # set to false when stat displays have their textures set
var player_summon_i_offset_bad_bug_fix = 0 # set to 1 after summoning first creature; probably bad-practice bug bix but it's a GameJam so who cares
var player_parried_last_turn = false # set to true after trying a parry move. Foes won't use an attack if you just went for a parry

var readied_moves = []
var berserk_moves = []

var battle_properties = [
	[],
	[]
]

var rng = RandomNumberGenerator.new()

func _ready():
	if get_parent():
		difficulty = get_parent().difficulty
		boss_phases = get_parent().boss_phases
		teams = get_parent().teams
		talismans = get_parent().talismans
		boss_fight = get_parent().boss_fight
	if boss_fight:
		teams[1] = [TheOnlyOne.new()]
	big_battle_anim.play("battle_start")
	for i in 8:
		battle_buttons.append(get_node("Battle Button " + str(i + 1)))
		battle_buttons[i].id = i
		battle_buttons[i].hide()
	for i in 2:
		for j in 20:
			status_buttons[i].append(get_node("Status Button " + str(i * 20 + 1 + j)))
	for i in teams[0]:
		add_child(i)
		i.position.x = -256
		i.team = 0
		i.sprite.offset.x = -512
		i.sprite.flip_h = false
		i.turns_alive = 0
		i.hide()
	for i in teams[1]:
		add_child(i)
		i.position.x = 256
		i.team = 1
		i.sprite.offset.x = 512
		i.sprite.flip_h = true
		i.turns_alive = 0
		i.hide()
	summon_creature(1, 0)
	update_names_and_stats()
	update_text_to_display(teams[1][0].display_name + " draws near!", false)
	page_button.hide()
	advance_text_button.show()
	await doneWithFirstSummon
	await advanceText
	display_summons(true)

func done_with_first_summon():
	emit_signal("doneWithFirstSummon")

func display_moves(reset_page: bool):
	if reset_page:
		advance_text_button.hide()
		page = 0
		berserk_moves = [] # contains the only moves you can use if berserk
		if battle_properties[0].size() > 0:
			for i in battle_properties[0]:
				if i.display_name == "Berserk":
					# Berserking time!
					var moves_to_pick_from = teams[0][0].moveset.duplicate(true)
					for j in min(2, teams[0][0].moveset.size()):
						var selected_move = moves_to_pick_from[randi_range(0, moves_to_pick_from.size() - 1)]
						berserk_moves.append(selected_move)
						moves_to_pick_from.pop_at(moves_to_pick_from.find(selected_move))
					page_button.hide()
		if teams[0][0].moveset.size() <= 8 or berserk_moves:
			page_button.hide()
		else:
			page_button.show()
	button_type = button_types["moves"]
	move_element.hide()
	update_text_to_display("Make your move.", false)
	for i in battle_buttons.size():
		if berserk_moves:
			if i < berserk_moves.size():
				var move = berserk_moves[i]
				if move.kills_user:
					battle_buttons[i].set_element_and_text(move.element_id, "[color=#ff1717]\t\t" + move.move_name + "[/color]")
				elif move.element_id in teams[1][0].weaknesses and move.deals_damage:
					battle_buttons[i].set_element_and_text(move.element_id, "[color=#fff700]\t\t" + move.move_name + "[/color]")
				else:
					battle_buttons[i].set_element_and_text(move.element_id, "\t\t" + move.move_name)
				battle_buttons[i].show()
			else:
				battle_buttons[i].hide()
		else:
			if i + page * 8 < teams[0][0].moveset.size():
				var move = teams[0][0].moveset[i + page * 8]
				if move.kills_user:
					battle_buttons[i].set_element_and_text(move.element_id, "[color=#ff1717]\t\t" + move.move_name + "[/color]")
				elif move.element_id in teams[1][0].weaknesses and move.deals_damage:
					battle_buttons[i].set_element_and_text(move.element_id, "[color=#fff700]\t\t" + move.move_name + "[/color]")
				else:
					battle_buttons[i].set_element_and_text(move.element_id, "\t\t" + move.move_name)
				battle_buttons[i].show()
			else:
				battle_buttons[i].hide()

func display_summons(reset_page: bool):
	if reset_page:
		advance_text_button.hide()
		page = 0
	button_type = button_types["summons"]
	move_element.hide()
	update_text_to_display("Summon a creature.", false)
	for i in battle_buttons.size():
		if i + page * 8 < teams[0].size() - player_summon_i_offset_bad_bug_fix:
			var creature = teams[0][i + player_summon_i_offset_bad_bug_fix + page * 8]
			if creature.bound_talisman:
				battle_buttons[i].set_element_and_text(-1, "\t\t[color=#ff4dfa]" + creature.display_name + "[/color]")
				battle_buttons[i].set_talisman_texture(creature.bound_talisman.texture_path, creature.bound_talisman.level)
			else:
				battle_buttons[i].set_element_and_text(creature.element_id, "\t\t" + creature.display_name)
			battle_buttons[i].show()
		else:
			battle_buttons[i].hide()
	if teams[0].size() > 8:
		page_button.show()
	else:
		page_button.hide()

func display_talismans(reset_page: bool):
	if reset_page:
		advance_text_button.hide()
		page = 0
	button_type = button_types["talismans"]
	move_element.hide()
	update_text_to_display("Attach a talisman?", false)
	for i in battle_buttons.size():
		if i + page * 8 <= talismans.size():
			if i + page * 8 == 0:
				battle_buttons[i].set_element_and_text(0, "\t\tLv. 1 (None)")
				battle_buttons[i].set_talisman_texture("none", 1)
			else:
				var talisman = talismans[i - 1 + page * 8]
				battle_buttons[i].set_element_and_text(0, "\t\tLv. " + str(talisman.level) + " " + talisman.display_name)
				battle_buttons[i].set_talisman_texture(talisman.texture_path, talisman.level)
			battle_buttons[i].show()
		else:
			battle_buttons[i].hide()
	if talismans.size() > 7:
		page_button.show()
	else:
		page_button.hide()

func describe_button(id: int):
	if button_type == button_types["moves"]:
		var move
		if berserk_moves:
			move = berserk_moves[id]
		else:
			move = teams[0][0].moveset[id + page * 8]
		if move.kills_user:
			if move.element_id in teams[1][0].weaknesses and move.deals_damage:
				update_text_to_display("\t\t" + move.move_name + " | Power: " + str(move.damage) + "% | Speed: " + str(move.action_speed) + "% | Accuracy: " + str(move.accuracy) + "%" + " | [color=#fff700]Advantage! (x1.5 Power)[/color]\n\t\t[color=#ff1717]Defeats the user. [/color]" + move.descr, false)
			else:
				update_text_to_display("\t\t" + move.move_name + " | Power: " + str(move.damage) + "% | Speed: " + str(move.action_speed) + "% | Accuracy: " + str(move.accuracy) + "%" + "\n\t\t[color=#ff1717]Defeats the user. [/color]" + move.descr, false)
		elif move.element_id in teams[1][0].weaknesses and move.deals_damage:
			update_text_to_display("\t\t" + move.move_name + " | Power: " + str(move.damage) + "% | Speed: " + str(move.action_speed) + "% | Accuracy: " + str(move.accuracy) + "%" + " | [color=#fff700]Advantage! (x1.5 Power)[/color]\n\t\t" + move.descr, false)
		else:
			update_text_to_display("\t\t" + move.move_name + " | Power: " + str(move.damage) + "% | Speed: " + str(move.action_speed) + "% | Accuracy: " + str(move.accuracy) + "%" + "\n\t\t" + move.descr, false)
		move_element.frame = move.element_id
		move_element.show()
	elif button_type == button_types["summons"]:
		var creature = teams[0][id + player_summon_i_offset_bad_bug_fix + page * 8]
		if creature.bound_talisman:
			update_text_to_display("\t\t[color=#ff4dfa]Lv. " + str(creature.bound_talisman.level) + " " + creature.display_name + "[/color] | Power: " + str(int(creature.power + creature.power * (creature.bound_talisman.level - 1) * 0.15)) + " | Speed: " + str(int(creature.speed + creature.speed * (creature.bound_talisman.level - 1) * 0.15)) + " | Health: " + str(int(creature.health + creature.health * (creature.bound_talisman.level - 1) * 0.15)) + " | [color=#ff4dfa]" + creature.bound_talisman.display_name + "[/color]\n\t\t", false)
		else:
			update_text_to_display("\t\t" + creature.display_name + " | Power: " + str(creature.power) + " | Speed: " + str(creature.speed) + " | Health: " + str(creature.health) + "\n\t\t", false)
		for i in creature.moveset.size():
			var move = creature.moveset[i]
			if move.kills_user:
				update_text_to_display("[color=#ff1717]" + move.move_name + "[/color]", true)
			elif move.element_id in teams[1][0].weaknesses and move.deals_damage:
				update_text_to_display("[color=#fff700]" + move.move_name + "[/color]", true)
			else:
				update_text_to_display(move.move_name, true)
			if i < creature.moveset.size() - 1:
				update_text_to_display(" | ", true)
		move_element.frame = creature.element_id
		move_element.show()
	elif button_type == button_types["talismans"]:
		if id + page * 8 == 0: # no talisman!
			update_text_to_display("None | Lv. 1 (0% stat boost)\nNo effects.", false)
		else:
			var talisman = talismans[id - 1 + page * 8]
			update_text_to_display(talisman.display_name + " | Lv. " + str(talisman.level) + " (" + str((talisman.level - 1) * 15) + "% stat boost)\n" + talisman.descr, false)

func describe_element(element_id: int):
	move_element.hide()
	if element_id == elements["none"]:
		battle_text.text = "None | Strong against nothing\nWeak to nothing"
	elif element_id == elements["ice"]:
		battle_text.text = "Ice | Strong against Water, Plant\nWeak to Fire, Light"
	elif element_id == elements["fire"]:
		battle_text.text = "Fire | Strong against Ice, Plant, Plague\nWeak to Water, Earth"
	elif element_id == elements["water"]:
		battle_text.text = "Water | Strong against Fire, Earth\nWeak to Ice, Plant, Light, Plague"
	elif element_id == elements["plant"]:
		battle_text.text = "Plant | Strong against Water, Earth, Light\nWeak to Ice, Fire, Plague"
	elif element_id == elements["earth"]:
		battle_text.text = "Earth | Strong against Fire, Light\nWeak to Water, Plant"
	elif element_id == elements["light"]:
		battle_text.text = "Light | Strong against Ice, Water, Plague\nWeak to Plant, Earth, Plague"
	elif element_id == elements["plague"]:
		battle_text.text = "Plague | Strong against Water, Plant, Light\nWeak to Fire, Light"
	elif element_id == elements["ether"]:
		battle_text.text = "Ether | Strong against everything\nWeak to everything"

func describe_status(team: int, status_id: int):
	if status_id < battle_properties[team].size():
		move_element.hide()
		status_id = min(status_id, battle_properties[team].size())
		if battle_properties[team][status_id].summon_boost:
			battle_text.text = battle_properties[team][status_id].display_name + " | " + battle_properties[team][status_id].descr
		elif battle_properties[team][status_id].is_terrain:
			battle_text.text = battle_properties[team][status_id].display_name + " (Terrain) | " + battle_properties[team][status_id].descr
		else:
			battle_text.text = battle_properties[team][status_id].display_name + " | " + battle_properties[team][status_id].descr

func describe_stat(stat_id: int):
	move_element.hide()
	if stat_id == 0:
		battle_text.text = "Power | Determines damage dealt by attacks."
	elif stat_id == 1:
		battle_text.text = "Speed | Faster creatures move first. Creatures can use high-speed moves to go even faster. The faster a creature is than the foe, the more likely the foe is to flinch."
	elif stat_id == 2 or stat_id == 4:
		battle_text.text = "Health | Creatures lose Health when they take damage. When their Health reaches 0, they perish."
	elif stat_id == 3 or stat_id == 5:
		battle_text.text = "Armor | Creatures lose Armor when they take damage, but indirect damage, such as Poisoned terrain, doesn't damage Armor. Armor also prevents this creature from flinching and healing."

func activate_moves():
	
	for i in 2:
		teams[i][0].turns_alive += 1
	
	for i in battle_buttons:
		i.hide()
	page_button.hide()
	advance_text_button.show()
	if !readied_moves:
		readied_moves = [teams[0][0].moveset[0], teams[1][0].moveset[0]]
	# compare speeds to determine who goes first
	var turn_order: Array # [0 for player, 1 for foe]
	var action_speeds = [readied_moves[0].action_speed * teams[0][0].speed, readied_moves[1].action_speed * teams[1][0].speed]
	
	var player_goes_first = false
	player_parried_last_turn = false
	
	for i in 2:
		for j in battle_properties[i]:
			action_speeds[i] *= j.extra_speed_multipliers(teams[i][0], teams[1 - i][0], readied_moves[i])
			if j.display_name == "Striking":
				player_goes_first = true
	for i in 2:
		for j in battle_properties[i]:
			if j.display_name == "Rough":
				if teams[i][0].weak_to_type(elements["earth"]):
					action_speeds[i] = min(action_speeds[i], 50 * teams[i][0].speed)
				else:
					action_speeds[i] = min(action_speeds[i], 100 * teams[i][0].speed)
	
	# parry check
	if player_goes_first or readied_moves[0].always_goes_first(teams[0][0], teams[1][0], readied_moves):
		turn_order = [0, 1]
	elif readied_moves[1].always_goes_first(teams[1][0], teams[0][0], readied_moves):
		turn_order = [1, 0]
	elif action_speeds[0] >= action_speeds[1]:
		turn_order = [0, 1]
	else:
		turn_order = [1, 0]
	
	move_element.hide()
	
	for i in 2:
		if !i and !teams[turn_order[i]][0].armor:
			for j in battle_properties[turn_order[i]]:
				if j.display_name == "Slick":
					var creature_feature = teams[turn_order[i]][0]
					if creature_feature.weak_to_type(elements["water"]):
						update_text_to_display("[color=#fff700]" + creature_feature.display_name + " slipped and took " + str(creature_feature.take_damage(action_speeds[turn_order[i]] * 0.01, false)) + " damage![/color]", false)
					else:
						update_text_to_display(creature_feature.display_name + " slipped and took " + str(creature_feature.take_damage(action_speeds[turn_order[i]] * 0.005, false)) + " damage!", false)
					update_names_and_stats()
					await advanceText
		for j in 2:
			if teams[j][0].time_to_die(battle_properties):
				if battle_properties[j].size() > 0:
					for k in range(battle_properties[j].size() - 1, -1, -1):
						if battle_properties[j][k].display_name == "Explosive":
							battle_properties[j].pop_at(k)
							update_text_to_display(teams[j][0].display_name + " blew up!", false)
							await advanceText
							teams[j][0].hide()
							teams[j][0].animate_move("Explode")
							update_text_to_display("\n" + str(int(teams[1 - j][0].take_damage(2 * teams[j][0].power, true))) + " damage!", true)
							update_names_and_stats()
							await advanceText
				if battle_properties[1 - j].size() > 0:
					for k in range(battle_properties[1 - j].size() - 1, -1, -1):
						if battle_properties[1 - j][k].tied_to_foe:
							battle_properties[1 - j].pop_at(k)
				death_message(j)
				await advanceText
		if teams[turn_order[i]][0].alive:
			var can_move = true
			for j in battle_properties[turn_order[i]]:
				if j.display_name == "Flinched":
					can_move = false
			if can_move:
				update_text_to_display(teams[turn_order[i]][0].display_name + " used " + readied_moves[turn_order[i]].move_name + "!", false)
				await advanceText
				var move_damage = use_move(readied_moves[turn_order[i]], turn_order[i], action_speeds) # returns 1 or more for damage dealers, -1 if it misses, and -2 for statuses
				await advanceText
				if move_damage > 0 and battle_properties[turn_order[i]].size() > 0:
					for j in range(battle_properties[turn_order[i]].size() - 1, -1, -1):
						var deal_damage_text = battle_properties[turn_order[i]][j].deal_damage(teams[turn_order[i]][0], teams[turn_order[1 - i]][0], move_damage)
						if deal_damage_text:
							update_text_to_display(deal_damage_text, false)
							update_names_and_stats()
							await advanceText
			else:
				update_text_to_display(teams[turn_order[i]][0].display_name + " flinched!", false)
				await advanceText
				update_text_to_display("\n[color=#ff1717]Too slow to move![/color]", true)
				await advanceText
	
		for j in 2:
			if teams[j][0].time_to_die(battle_properties):
				if battle_properties[j].size() > 0:
					for k in range(battle_properties[j].size() - 1, -1, -1):
						if battle_properties[j][k].display_name == "Explosive":
							battle_properties[j].pop_at(k)
							update_text_to_display(teams[j][0].display_name + " blew up!", false)
							await advanceText
							teams[j][0].hide()
							teams[j][0].animate_move("Explode")
							update_text_to_display("\n" + str(int(teams[1 - j][0].take_damage(2 * teams[j][0].power, true))) + " damage!", true)
							update_names_and_stats()
							await advanceText
				if battle_properties[1 - j].size() > 0:
					for k in range(battle_properties[1 - j].size() - 1, -1, -1):
						if battle_properties[1 - j][k].tied_to_foe:
							battle_properties[1 - j].pop_at(k)
				death_message(j)
				await advanceText
	
	readied_moves = []
	
	for i in 2:
		if battle_properties[i].size() > 0:
			for j in range(battle_properties[i].size() - 1, -1, -1):
				var end_of_turn_text = battle_properties[i][j].end_of_turn(teams[i][0], teams[1 - i][0])
				if end_of_turn_text:
					update_text_to_display(end_of_turn_text, false)
					update_names_and_stats()
					await advanceText
				if battle_properties[i][j].lasts_one_turn:
					battle_properties[i].pop_at(j)
	
	for j in 2:
		if teams[j][0].time_to_die(battle_properties):
			if battle_properties[j].size() > 0:
				for k in range(battle_properties[j].size() - 1, -1, -1):
					if battle_properties[j][k].display_name == "Explosive":
						battle_properties[j].pop_at(k)
						update_text_to_display(teams[j][0].display_name + " blew up!", false)
						await advanceText
						teams[j][0].hide()
						teams[j][0].animate_move("Explode")
						update_text_to_display("\n" + str(int(teams[1 - j][0].take_damage(2 * teams[j][0].power, true))) + " damage!", true)
						update_names_and_stats()
						await advanceText
				if battle_properties[1 - j].size() > 0:
					for k in range(battle_properties[1 - j].size() - 1, -1, -1):
						if battle_properties[1 - j][k].tied_to_foe:
							battle_properties[1 - j].pop_at(k)
			death_message(j)
			await advanceText
	
	# this segment gets rid of anchors if any are in play and saved your life
	for j in 2:
		var creature = teams[j][0]
		if creature.alive and creature.health <= 0 and creature.armor <= 0:
			for k in range(battle_properties[j].size() - 1, -1, -1):
				if battle_properties[j][k].display_name == "Anchored":
					battle_properties[j].pop_at(k)
					if creature.max_armor:
						creature.armor = 1
					else:
						creature.health = 1
					update_text_to_display(creature.display_name + " held on to its anchor!", false)
					update_names_and_stats()
					await advanceText
	
	update_names_and_stats()
	
	# is the foe dead?
	if !teams[1][0].alive:
		# is the foe FULLY DEAD???
		if teams[1].size() <= 1:
			win_encounter()
			await advanceText
			teams[0].pop_at(0)
			# help the creatures not go null
			for i in teams[0]:
				remove_child(i)
			if boss_fight:
				get_parent().get_parent().change_scene(get_parent().get_parent().scenes["title"])
			else:
				get_parent().award_rewards()
				get_parent().change_scene(get_parent().scenes["overworld"])
		# are you FULLY DEAD???
		elif !teams[0][0].alive and teams[0].size() <= 1:
			lose_encounter()
			await advanceText
			get_parent().get_parent().change_scene(get_parent().get_parent().scenes["title"])
		# foe lost a dude, summons next (you're still alive)
		else:
			if battle_properties[1].size() > 0:
				for j in range(battle_properties[1].size() - 1, -1, -1):
					if !battle_properties[1][j].is_terrain:
						battle_properties[1].pop_at(j)
			battle_properties[1].append(JustifiedStatus.new())
			update_names_and_stats()
			summon_creature(1, 1)
			update_text_to_display(teams[1][0].display_name + " draws near!", false)
			await advanceText
			if battle_properties[1].size() > 0:
				for i in range(battle_properties[1].size() - 1, -1, -1):
					var summon_text = battle_properties[1][i].on_summon(teams[1][0])
					if summon_text:
						if battle_properties[1][i].lasts_one_turn:
							battle_properties[1].pop_at(i)
						update_text_to_display(summon_text, false)
						update_names_and_stats()
						await advanceText
	# are you dead?
	if !battle_over and !teams[0][0].alive:
		if teams[0].size() <= 1:
			lose_encounter()
			await advanceText
			get_parent().get_parent().change_scene(get_parent().get_parent().scenes["title"])
		else:
			if battle_properties[0].size() > 0:
				for j in range(battle_properties[0].size() - 1, -1, -1):
					if !battle_properties[0][j].is_terrain:
						battle_properties[0].pop_at(j)
			battle_properties[0].append(JustifiedStatus.new())
			update_names_and_stats()
			display_summons(true)
	# returns to move selection otherwise
	elif !battle_over:
		display_moves(true)

func use_move(move: BaseMove, user: int, action_speeds: Array) -> int:
	if (move.deals_damage and !teams[1 - user][0].alive) or move.failing:
		update_text_to_display("\n" + move.on_fail(teams[user][0], teams[1 - user][0], battle_properties, talismans), true)
		teams[user][0].animate_move("Miss")
		update_names_and_stats()
		return -2
	elif move.deals_damage:
		var accuracy = move.accuracy
		for i in battle_properties[user]:
			accuracy *= i.extra_accuracy_multipliers(teams[user][0], teams[1 - user][0], move)
		for i in battle_properties[1 - user]:
			accuracy *= i.extra_accuracy_intake_multipliers(teams[user][0], teams[1 - user][0], move)
		if rng.randf_range(0, 100) > accuracy:
			# move misses!
			update_text_to_display("\n[color=#ff1717]But it missed![/color]", true)
			teams[user][0].animate_move("Miss")
			return -1
		else:
			var move_damage: int
			var damage_limiter = 0
			for i in range(battle_properties[user].size() - 1, -1, -1):
				if battle_properties[user][i].display_name == "Chilling":
					if teams[user][0].weak_to_type(elements["ice"]):
						damage_limiter = 0.7
					else:
						damage_limiter = 1
			if move.element_id in teams[1 - user][0].weaknesses:
				if damage_limiter:
					move_damage = int(teams[1 - user][0].take_damage(min(0.01 * 1.5 * move.get_damage(teams[user][0], teams[1 - user][0], battle_properties), damage_limiter * teams[user][0].power), true))
				else:
					move_damage = int(teams[1 - user][0].take_damage(0.01 * 1.5 * move.get_damage(teams[user][0], teams[1 - user][0], battle_properties), true))
				update_text_to_display("\n[color=#fff700]" + str(move_damage) + " damage![/color]", true)
			else:
				if damage_limiter:
					move_damage = int(teams[1 - user][0].take_damage(min(0.01 * move.get_damage(teams[user][0], teams[1 - user][0], battle_properties), damage_limiter * teams[user][0].power), true))
				else:
					move_damage = int(teams[1 - user][0].take_damage(0.01 * move.get_damage(teams[user][0], teams[1 - user][0], battle_properties), true))
				update_text_to_display("\n" + str(move_damage) + " damage!", true)
			if try_to_flinch(user, action_speeds):
				update_text_to_display(" " + move.flinch_effects(teams[user][0], teams[1 - user][0], battle_properties), true)
			update_text_to_display(" " + move.on_hit(teams[user][0], teams[1 - user][0], battle_properties, talismans), true)
			teams[user][0].animate_move(move.move_animation)
			update_names_and_stats()
			return move_damage
	else:
		var succeeds = true
		for i in battle_properties[user]:
			if i.display_name == "Filtered":
				succeeds = false
		if succeeds:
			teams[user][0].animate_move(move.move_animation)
			update_text_to_display("\n" + move.on_hit(teams[user][0], teams[1 - user][0], battle_properties, talismans), true)
			if try_to_flinch(user, action_speeds):
				update_text_to_display(" " + move.flinch_effects(teams[user][0], teams[1 - user][0], battle_properties), true)
		elif teams[user][0].weak_to_type(elements["light"]):
			update_text_to_display("\n[color=#ff1717]But filtered light punished " + teams[user][0].display_name + " for " + str(int(teams[user][0].take_damage(teams[user][0].max_health * 0.3, false))) + " damage![/color]", true)
			teams[user][0].animate_move("Miss")
		else:
			update_text_to_display("\n[color=#ff1717]But filtered light prevented it![/color]", true)
			teams[user][0].animate_move("Miss")
		update_names_and_stats()
		return -2

func update_names_and_stats():
	for i in 2:
		element_displays[i].frame = teams[i][0].element_id
		name_displays[i].text = TEAM_TEXT_OFFSETS[i] + "Lv. " + str(teams[i][0].level) + " " + teams[i][0].display_name
		# stat_displays[i].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].health)) + "/" + str(int(teams[i][0].max_health)) + "\n" + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed))
		if first_stat_update:
			stat_displays[i][1].texture_normal = load("res://assets/ui/battle/stat_power.png")
			stat_displays[i][1].texture_hover = load("res://assets/ui/battle/stat_power_hovered.png")
			stat_displays[i][1].texture_pressed = load("res://assets/ui/battle/stat_power_hovered.png")
			stat_displays[i][2].texture_normal = load("res://assets/ui/battle/stat_speed.png")
			stat_displays[i][2].texture_hover = load("res://assets/ui/battle/stat_speed_hovered.png")
			stat_displays[i][2].texture_pressed = load("res://assets/ui/battle/stat_speed_hovered.png")
		if teams[i][0].boss:
			if teams[i][0].max_armor:
				if stat_displays[i][3].id != 5:
					stat_displays[i][3].id = 5
					stat_displays[i][3].texture_normal = load("res://assets/ui/battle/stat_armor_boss.png")
					stat_displays[i][3].texture_hover = load("res://assets/ui/battle/stat_armor_boss_hovered.png")
					stat_displays[i][3].texture_pressed = load("res://assets/ui/battle/stat_armor_boss_hovered.png")
				stat_displays[i][0].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed)) + "\n" + str(int(teams[i][0].armor)) + "/" + str(int(teams[i][0].max_armor))
				health_bars[i].max_value = teams[i][0].max_armor
				health_bars[i].value = teams[i][0].armor
				health_bars[i].tint_progress = Color.from_hsv(0.8, 1.0, 1.0)
			else:
				if stat_displays[i][3].id != 4:
					stat_displays[i][3].id = 4
					stat_displays[i][3].texture_normal = load("res://assets/ui/battle/stat_health_boss.png")
					stat_displays[i][3].texture_hover = load("res://assets/ui/battle/stat_health_boss_hovered.png")
					stat_displays[i][3].texture_pressed = load("res://assets/ui/battle/stat_health_boss_hovered.png")
				stat_displays[i][0].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed)) + "\n" + str(int(teams[i][0].health)) + "/" + str(int(teams[i][0].max_health))
				health_bars[i].max_value = teams[i][0].max_health
				health_bars[i].value = teams[i][0].health
				health_bars[i].tint_progress = Color.from_hsv(1 - 0.2 * (health_bars[i].value / health_bars[i].max_value), 1.0, 1.0)
		else:
			if teams[i][0].max_armor:
				if stat_displays[i][3].id != 3:
					stat_displays[i][3].id = 3
					stat_displays[i][3].texture_normal = load("res://assets/ui/battle/stat_armor.png")
					stat_displays[i][3].texture_hover = load("res://assets/ui/battle/stat_armor_hovered.png")
					stat_displays[i][3].texture_pressed = load("res://assets/ui/battle/stat_armor_hovered.png")
				stat_displays[i][0].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed)) + "\n" + str(int(teams[i][0].armor)) + "/" + str(int(teams[i][0].max_armor))
				health_bars[i].max_value = teams[i][0].max_armor
				health_bars[i].value = teams[i][0].armor
				health_bars[i].tint_progress = Color.from_hsv(0.15, 1.0, 1.0)
			else:
				if stat_displays[i][3].id != 2:
					stat_displays[i][3].id = 2
					stat_displays[i][3].texture_normal = load("res://assets/ui/battle/stat_health.png")
					stat_displays[i][3].texture_hover = load("res://assets/ui/battle/stat_health_hovered.png")
					stat_displays[i][3].texture_pressed = load("res://assets/ui/battle/stat_health_hovered.png")
				stat_displays[i][0].text = TEAM_TEXT_OFFSETS[i] + str(int(teams[i][0].power)) + "\n" + str(int(teams[i][0].speed)) + "\n" + str(int(teams[i][0].health)) + "/" + str(int(teams[i][0].max_health))
				health_bars[i].max_value = teams[i][0].max_health
				health_bars[i].value = teams[i][0].health
				health_bars[i].tint_progress = Color.from_hsv(0.35 * (health_bars[i].value / health_bars[i].max_value), 1.0, 1.0)
		for j in status_buttons[i].size():
			if j < battle_properties[i].size():
				status_buttons[i][j].frame = battle_properties[i][j].element_id
				status_buttons[i][j].show()
				# battle_properties[i][j]
			else:
				status_buttons[i][j].hide()
	if player_summon_i_offset_bad_bug_fix == 0:
		element_displays[0].hide()
		health_bars[0].hide()
		name_displays[0].text = ""
	if first_stat_update:
		first_stat_update = false

func play_camera_anim(anim_name: String):
	anim.stop()
	$"Camera2D".offset = Vector2.ZERO
	$"Middle Box".self_modulate = Color.from_hsv(0.0, 0.0, 1.0)
	anim.play(anim_name)

func button_pressed(id: int):
	if button_type == button_types["moves"]:
		if berserk_moves:
			readied_moves.append(berserk_moves[id])
		else:
			readied_moves.append(teams[0][0].moveset[id + page * 8])
		readied_moves.append(ai_select_move())
		activate_moves()
	elif button_type == button_types["summons"]:
		summon_creature(0, id + player_summon_i_offset_bad_bug_fix + page * 8)
		if teams[0][0].bound_talisman:
			var talisman = teams[0][0].bound_talisman
			teams[0][0].level_up(talisman.level)
			talisman.play_talisman(teams[0][0], teams[1][0], battle_properties)
			update_names_and_stats()
			if battle_properties[0].size() > 0:
				for i in battle_buttons:
					i.hide()
				page_button.hide()
				move_element.hide()
				advance_text_button.show()
				for i in range(battle_properties[0].size() - 1, -1, -1):
					var summon_text = battle_properties[0][i].on_summon(teams[0][0])
					if summon_text:
						if battle_properties[0][i].lasts_one_turn:
							battle_properties[0].pop_at(i)
						update_text_to_display(summon_text, false)
						update_names_and_stats()
						await advanceText
			display_moves(true)
		else:
			display_talismans(true)
	elif button_type == button_types["talismans"]:
		if id + page * 8:
			var talisman = talismans[id - 1 + page * 8]
			teams[0][0].bound_talisman = talisman
			teams[0][0].level_up(talisman.level)
			talisman.play_talisman(teams[0][0], teams[1][0], battle_properties)
			talismans.pop_at(talismans.find(talisman))
			update_names_and_stats()
		if battle_properties[0].size() > 0:
			for i in battle_buttons:
				i.hide()
			page_button.hide()
			move_element.hide()
			advance_text_button.show()
			for i in range(battle_properties[0].size() - 1, -1, -1):
				var summon_text = battle_properties[0][i].on_summon(teams[0][0])
				if summon_text:
					if battle_properties[0][i].lasts_one_turn:
						battle_properties[0].pop_at(i)
					update_text_to_display(summon_text, false)
					update_names_and_stats()
					await advanceText
		display_moves(true)

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
	if !creature.boss:
		creature.ready_element()
		for i in creature.moveset:
			i._init()
	creature.skew = 0
	creature.sprite.show()
	if creature.boss:
		creature.level_up(creature.level)
	elif creature.bound_talisman:
		creature.level_up(creature.bound_talisman.level)
	else:
		creature.level_up(1)
	creature.animate_spawn()
	creature.alive = true
	creature.invincible = false
	if team == 0 and player_summon_i_offset_bad_bug_fix == 0:
		player_summon_i_offset_bad_bug_fix = 1
		big_battle_anim.stop(true)
		big_battle_anim.play("fade_in_player")
		element_displays[0].show()
		health_bars[0].show()
	clear_immune_ailments(creature)
	update_names_and_stats()

func ai_select_move() -> BaseMove:
	var viable_moves = []
	var moves_to_pick_from = []
	var user = teams[1][0]
	var target = teams[0][0]
	var highest_priority = -100
	for i in teams[1][0].moveset.size():
		viable_moves.append([0, teams[1][0].moveset[i]])
	for i in viable_moves.size():
		var testing_move: BaseMove = viable_moves[i][1]
		# super effective attacks get +1 priority, attacks after player tries to parry get -9 priority
		if testing_move.deals_damage:
			if target.weak_to_type(testing_move.element_id):
				viable_moves[i][0] += 1
			if player_parried_last_turn:
				viable_moves[i][0] -= 9
		# self destruct moves get +10 priority if it's been too long, +1 priority when low on health, and suck otherwise
		if testing_move.kills_user:
			if user.turns_alive >= 10 and target.turns_alive >= 10:
				viable_moves[i][0] += 10
			elif !user.armor and user.health < 0.3 * user.max_health and teams[user.team].size() > 1:
				viable_moves[i][0] += 1
			else:
				viable_moves[i][0] -= 12
		# move-specific ai behaviors
		viable_moves[i][0] += testing_move.ai_priority(user, target, battle_properties)
		# sets highest priority to own if in the highest priority
		highest_priority = max(highest_priority, viable_moves[i][0])
	for i in viable_moves.size():
		if viable_moves[i][0] == highest_priority:
			moves_to_pick_from.append(viable_moves[i][1])
	if moves_to_pick_from.size() == 1:
		return moves_to_pick_from[0]
	elif moves_to_pick_from.size() == 0:
		return user.moveset[0]
	else:
		return moves_to_pick_from[randi_range(0, moves_to_pick_from.size() - 1)]

func win_encounter():
	if !battle_over:
		if boss_fight:
			update_text_to_display("[color=#0fff00]You have ended the Reign of the Only One![/color]", false)
			get_parent().get_parent().beat_game = true
		else:
			update_text_to_display("[color=#fff700]You survived![/color]", false)
		battle_over = true

func lose_encounter():
	if !battle_over:
		update_text_to_display("[color=#ff1717]Your journey is over![/color]", false)
		battle_over = true

func try_to_flinch(user: int, action_speeds: Array) -> bool:
	for i in battle_properties[user]:
		if i.display_name == "Striking":
			for j in battle_properties[1 - user]:
				if j.display_name == "Flinched":
					return false
			battle_properties[1 - user].append(FlinchedStatus.new())
			return true
	for i in battle_properties[1 - user]:
		if i.display_name == "Steadfast":
			return false
	
	var chance_to = float(action_speeds[1 - user]) / float(action_speeds[user])
	if rng.randf_range(0, 1) > max(0.25, chance_to) and !teams[1 - user][0].armor: # if true, try to flinch! chance_to is actually 1 - chance_to, and chance to flinch caps at 80%
		for i in battle_properties[1 - user]:
			if i.display_name == "Flinched":
				return false
		battle_properties[1 - user].append(FlinchedStatus.new())
		return true
	return false

func next_page():
	page += 1
	if button_type == button_types["summons"]:
		if page * 8 >= teams[0].size():
			page = 0
		display_summons(false)
	elif button_type == button_types["talismans"]:
		if page * 8 > talismans.size():
			page = 0
		display_talismans(false)
	elif button_type == button_types["moves"]:
		if page * 8 >= teams[0][0].moveset.size():
			page = 0
		display_moves(false)

func update_text_to_display(text: String, add: bool):
	if add:
		text_should_display += text
	else:
		text_should_display = text
	battle_text.text = text_should_display

func clear_immune_ailments(user: BaseCreature):
	if battle_properties[user.team].size() > 0:
		for i in range(battle_properties[user.team].size() - 1, -1, -1):
			if battle_properties[user.team][i].element_id == user.element_id:
				battle_properties[user.team].pop_at(i)

func death_message(j: int):
	if teams[j][0].boss:
		if boss_phases.size() > 0:
			teams[j][0].revive()
			update_names_and_stats()
			update_text_to_display("[color=#ff1717]" + teams[j][0].display_name + " refused to die![/color]", false)
		else:
			teams[j][0].perish()
			update_text_to_display(TEAM_TEXT_OFFSETS[j + 4] + teams[j][0].display_name + " has been vanquished![/color]", false)
	else:
		update_text_to_display(TEAM_TEXT_OFFSETS[j + 4] + teams[j][0].display_name + " has fallen![/color]", false)

func animate_in_text():
	big_battle_anim.stop(true)
	big_battle_anim.play("fade_in_text")

func pop_non_terrains_on_revive():
	if battle_properties[1].size() > 0:
		for j in range(battle_properties[1].size() - 1, -1, -1):
			if !battle_properties[1][j].is_terrain:
				battle_properties[1].pop_at(j)
