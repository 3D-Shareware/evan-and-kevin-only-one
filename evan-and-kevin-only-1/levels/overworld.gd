extends Node2D

enum scenes {overworld, battle}

var phase_names = {0: "None", 1: "Ice", 2: "Fire", 3: "Water", 4: "Plant", 5: "Earth", 6: "Light", 7: "Plague"}

@onready var buttons = [$"Button 1", $"Button 2", $"Button 3"]
@onready var text = $"Label"
@onready var instructions = $"Instructions"

# all this stuff gets set by parent
var difficulty: int
var boss_phases = []
var teams: Array
var talismans: Array
var turns: int

# parent-handled, exclusive to overworld
var known_phases: int

var rewards = [[], []]
var enemies = [[], []]
var text_displays = ["", "", ""]

var all_creatures = [
	PeepsicleCreature, IceopodCreature, SnowtankCreature, KitsauroraCreature,
	SmeltynxCreature, JellfireCreature, FeyereCreature, FlamengoCreature,
	SturglockCreature, BlubbitCreature, BrinotaurCreature, ScubalusCreature,
	TimboarCreature, ShrikadeeCreature, BamboldCreature, GardeanCreature,
	QuakenCreature, RockstrichCreature, DiamondflyCreature, WatchearthCreature,
	CaongCreature, PaladogCreature, ShinosaurCreature, SuperNovaCreature,
	GouroborosCreature, AlchemouseCreature, FamaneCreature, ResentanaCreature
]

var all_talismans = [
	AimingTalisman, AnchoringTalisman, BerserkTalisman, EtherTalisman, ExplosiveTalisman, ImpactTalisman,
	RegenerativeTalisman, SimpleTalisman, SteadfastTalisman, StrikingTalisman, VoidTalisman, WeirdTalisman
]

func _ready() -> void:
	if get_parent():
		difficulty = get_parent().difficulty
		boss_phases = get_parent().boss_phases
		teams = get_parent().teams
		talismans = get_parent().talismans
		turns = get_parent().turns
		known_phases = get_parent().known_phases
	for i in buttons.size():
		buttons[i].id = i + 1
	if difficulty:
		if turns == 1:
			instructions.text = "[center]Pick a starting team.\nOnce a creature is summoned, it's lost from the party, even if it survives the battle.[/center]"
			for i in buttons.size():
				buttons[i].show()
				if i == 0:
					buttons[i].set_element_and_text(-1, "[center]Team α [/center]")
					buttons[i].talisman.hide()
				elif i == 1:
					buttons[i].set_element_and_text(-1, "[center]Team β [/center]")
					buttons[i].talisman.hide()
				else:
					buttons[i].hide()
		else:
			instructions.text = "[center]Pick a battle.\nYour party: "
			for i in teams[0].size():
				if teams[0][i].bound_talisman:
					instructions.text += "Lv. " + str(teams[0][i].bound_talisman.level) + " " + str(teams[0][i].bound_talisman.display_name) + " " + teams[0][i].display_name
				else:
					instructions.text += teams[0][i].display_name
				if i < teams[0].size() - 1:
					instructions.text += ", "
			if talismans.size() > 0:
				instructions.text += "\nYour talismans: "
				for i in talismans.size():
					instructions.text += "Lv. " + str(talismans[i].level) + " " + talismans[i].display_name
					if i < talismans.size() - 1:
						instructions.text += ", "
			instructions.text += "[/center]"
			for i in buttons.size():
				buttons[i].show()
				if i == 0:
					buttons[i].set_element_and_text(-1, "[center]Battle α [/center]")
					buttons[i].talisman.hide()
				elif i == 1:
					buttons[i].set_element_and_text(-1, "[center]Battle β [/center]")
					buttons[i].talisman.hide()
				else:
					buttons[i].set_element_and_text(-1, "[center]The Only One [/center]")
					buttons[i].talisman.hide()
		calc_rewards()
	else:
		for i in buttons.size():
			buttons[i].show()
			if i == 0:
				buttons[i].set_element_and_text(-1, "\t\tCasual")
				buttons[i].set_talisman_texture("regenerative", 1)
			elif i == 1:
				buttons[i].set_element_and_text(-1, "\t\tNormal")
				buttons[i].set_talisman_texture("anchoring", 2)
			else:
				buttons[i].set_element_and_text(-1, "\t\tExtreme")
				buttons[i].set_talisman_texture("impact", 3)

func describe_button(id: int):
	if difficulty:
		text.text = text_displays[id - 1]
	else:
		if id == 1:
			text.text = "Recommended for people who don't want to struggle.\nEnemies have lower levels, strong rewards are handed out frequently, and the final boss is easier."
		elif id == 2:
			text.text = "Recommended for people who want to be challenged by the game.\nDefault settings."
		else:
			text.text = "Recommended for people who know what they're doing and want to lose.\nEnemies have far higher levels, and the final boss is tougher."

func button_pressed(id: int):
	if !difficulty:
		difficulty = id
		get_parent().difficulty = difficulty
		get_parent().set_up_game()
	elif turns == 1:
		get_parent().battle_rewards = rewards[id - 1]
		get_parent().enemies = enemies[id - 1]
		get_parent().award_rewards()
		get_parent().change_scene(scenes["overworld"])
	else:
		if id == 3:
			get_parent().battle_rewards = []
			get_parent().initiate_battle(true)
		else:
			get_parent().battle_rewards = rewards[id - 1]
			get_parent().enemies = enemies[id - 1]
			get_parent().initiate_battle(false)

func calc_rewards():
	var creatures_rewarded = [0, 0]
	var bound_creatures = [false, false]
	var talismans_rewarded = [0, 0]
	var creatures_to_fight = 0
	var knowledge_rewarded = false
	if turns == 1:
		creatures_rewarded[0] = 3
		creatures_rewarded[1] = 3
		if difficulty == 1:
			talismans_rewarded[0] = 3
			talismans_rewarded[1] = 3
		else:
			talismans_rewarded[0] = 2
			talismans_rewarded[1] = 2
	else:
		if turns == 2:
			creatures_rewarded[0] = 1
			creatures_rewarded[1] = 1
			talismans_rewarded[0] = 3
			talismans_rewarded[1] = 3
		else:
			for i in 2:
				var rng = randi_range(1, 100)
				if rng > 85: # HUGE talisman dump
					creatures_rewarded[i] = 0
					talismans_rewarded[i] = 5
				elif rng > 70: # BIG powerful creature
					creatures_rewarded[i] = 1
					talismans_rewarded[i] = randi_range(0, 2)
					bound_creatures[i] = true
				elif rng > 55: # LOTS of creatures
					creatures_rewarded[i] = 3
					talismans_rewarded[i] = 0
				else:
					creatures_rewarded[i] = randi_range(0, 1)
					talismans_rewarded[i] = randi_range(1, 3)
		if difficulty == 1:
			creatures_to_fight = 2
			for i in 2:
				creatures_rewarded[i] += 2
				talismans_rewarded[i] += 3
		else:
			@warning_ignore("integer_division")
			creatures_to_fight = int(2 + floor(turns / 3))
		if known_phases < boss_phases.size() - 1 and turns % 3 == 0:
			knowledge_rewarded = true
	
	var enemy_level = 1
	if difficulty == 3:
		@warning_ignore("integer_division")
		enemy_level = int(2 + floor(turns / 3))
	for i in 2:
		if creatures_to_fight:
			for j in creatures_to_fight:
				var new_enemy = all_creatures[randi_range(0, all_creatures.size() - 1)].new()
				var new_talisman = UnusuedTalisman.new()
				new_talisman.level = enemy_level
				new_enemy.bound_talisman = new_talisman
				new_enemy.level_up(new_talisman.level)
				enemies[i].append(new_enemy)
	
	var talisman_strength = 1
	if difficulty == 1:
		@warning_ignore("integer_division")
		talisman_strength = int(2 + floor(turns / 2))
	else:
		@warning_ignore("integer_division")
		talisman_strength = int(1 + floor(turns / 3))
	
	for i in 2:
		if creatures_rewarded[i]:
			for j in creatures_rewarded[i]:
				if bound_creatures[i]:
					var new_creature = BoundCreatureReward.new()
					new_creature.set_reward(self, talisman_strength)
					rewards[i].append(new_creature)
				else:
					var new_creature = CreatureReward.new()
					new_creature.set_reward(self, talisman_strength)
					rewards[i].append(new_creature)
	
	for i in 2:
		if talismans_rewarded[i]:
			for j in talismans_rewarded[i]:
				var new_talisman = TalismanReward.new()
				new_talisman.set_reward(self, talisman_strength)
				rewards[i].append(new_talisman)
	
	for i in 2:
		if knowledge_rewarded:
			var new_reward = KnowledgeReward.new()
			new_reward.set_reward(self, 0)
			rewards[i].append(new_reward)
	
	for i in 2:
		if enemies[i]:
			text_displays[i] = "Fight: "
			for j in enemies[i].size():
				text_displays[i] += enemies[i][j].display_name
				if j < enemies[i].size() - 1:
					text_displays[i] += ", "
				else:
					text_displays[i] += "\nRewards: Enemies defeated, "
		else:
			text_displays[i] += "Start with: "
		if rewards[i]:
			for j in rewards[i].size():
				text_displays[i] += rewards[i][j].display_name
				if j < rewards[i].size() - 1:
					text_displays[i] += ", "
		else:
			text_displays[i] += "nothing"
	
	text_displays[2] = "Fight: The Only One | Phases: "
	for i in boss_phases.size() - 1:
		if known_phases > i:
			text_displays[2] += phase_names[boss_phases[i]]
		else:
			text_displays[2] += "???"
		if i < boss_phases.size() - 2:
			text_displays[2] += ", "
	text_displays[2] += "\nRewards: Freeing the realm"
