extends Node2D

@onready var element_displays = [$"Player Element"]
@onready var name_displays = [$"Player Element/Player Creature Text"]
@onready var stat_displays = [[$"Player Element/Stat Text", $"Player Element/Power", $"Player Element/Speed", $"Player Element/Health"]]
@onready var battle_text = $"Battle Text"
@onready var move_element = $"Move Element"
@onready var anim = $"Camera2D/Camera Animator"
@onready var health_bars = [$"Player Element/Player Health"]
@onready var page_button = $"Page Button"
@onready var title_button = $"Back to Title"
@onready var big_battle_anim = $"AnimationPlayer"

signal doneWithFirstSummon
signal advanceText

var text_should_display = ""

var display_creature = null

var all_creatures = [
	PeepsicleCreature.new(), IceopodCreature.new(), SnowtankCreature.new(), KitsauroraCreature.new(),
	SmeltynxCreature.new(), JellfireCreature.new(), FeyereCreature.new(), FlamengoCreature.new(),
	SturglockCreature.new(), BlubbitCreature.new(), BrinotaurCreature.new(), ScubalusCreature.new(),
	TimboarCreature.new(), ShrikadeeCreature.new(), BamboldCreature.new(), GardeanCreature.new(),
	QuakenCreature.new(), RockstrichCreature.new(), DiamondflyCreature.new(), WatchearthCreature.new(),
	PaladogCreature.new(), CaongCreature.new(), ShinosaurCreature.new(), SuperNovaCreature.new(),
	GouroborosCreature.new(), AlchemouseCreature.new(), ResentanaCreature.new(), FamaneCreature.new()
]

var battle_buttons = []

var page = 0 # used to display lots of buttons
var first_stat_update = true
var player_summon_i_offset_bad_bug_fix = 0

func _ready() -> void:
	big_battle_anim.play("battle_start")
	if get_parent().beat_game:
		all_creatures.append(TheOnlyOne.new())
	for i in all_creatures:
		add_child(i)
		i.hide()
	for i in 4:
		battle_buttons.append(get_node("Battle Button " + str(i + 1)))
		battle_buttons[i].id = i
		battle_buttons[i].hide()
	# summon display creature
	summon_creature(0)
	update_names_and_stats()
	display_summons()
	page_button.show()
	title_button.set_element_and_text(-1, "[center]Back to Title [/center]")
	title_button.show()
	# await doneWithFirstSummon
	await advanceText
	get_parent().change_scene(get_parent().scenes["title"])

func summon_creature(id: int):
	if display_creature != null:
		display_creature.hide()
	display_creature = all_creatures[id]
	display_creature.position.x = -256
	display_creature.team = 0
	display_creature.sprite.offset.x = -512
	display_creature.sprite.flip_h = false
	display_creature.turns_alive = 0
	display_creature.show()
	if display_creature.boss:
		display_creature.level_up(display_creature.level)
	elif display_creature.bound_talisman:
		display_creature.level_up(display_creature.bound_talisman.level)
	else:
		display_creature.level_up(1)
	display_creature.animate_spawn()
	display_creature.alive = true
	display_creature.invincible = false
	if player_summon_i_offset_bad_bug_fix == 0:
		player_summon_i_offset_bad_bug_fix = 1
		big_battle_anim.stop(true)
		big_battle_anim.play("fade_in_player")
		element_displays[0].show()
		health_bars[0].show()
	update_text_to_display(display_creature.descr, false)
	# update_text_to_display(display_creature.display_name + " draws near!", false)
	update_names_and_stats()

func animate_in_text():
	big_battle_anim.stop(true)
	big_battle_anim.play("fade_in_text")

func done_with_first_summon():
	emit_signal("doneWithFirstSummon")

func update_text_to_display(text: String, add: bool):
	if add:
		text_should_display += text
	else:
		text_should_display = text
	battle_text.text = text_should_display

func update_names_and_stats():
	element_displays[0].frame = display_creature.element_id
	name_displays[0].text = "[left]Lv. " + str(display_creature.level) + " " + display_creature.display_name
	# stat_displays[i].text = TEAM_TEXT_OFFSETS[i] + str(int(display_creature.health)) + "/" + str(int(display_creature.max_health)) + "\n" + str(int(display_creature.power)) + "\n" + str(int(display_creature.speed))
	if first_stat_update:
		stat_displays[0][1].texture_normal = load("res://assets/ui/battle/stat_power.png")
		stat_displays[0][1].texture_hover = load("res://assets/ui/battle/stat_power_hovered.png")
		stat_displays[0][1].texture_pressed = load("res://assets/ui/battle/stat_power_hovered.png")
		stat_displays[0][2].texture_normal = load("res://assets/ui/battle/stat_speed.png")
		stat_displays[0][2].texture_hover = load("res://assets/ui/battle/stat_speed_hovered.png")
		stat_displays[0][2].texture_pressed = load("res://assets/ui/battle/stat_speed_hovered.png")
	if display_creature.boss:
		if display_creature.max_armor:
			if stat_displays[0][3].id != 5:
				stat_displays[0][3].id = 5
				stat_displays[0][3].texture_normal = load("res://assets/ui/battle/stat_armor_boss.png")
				stat_displays[0][3].texture_hover = load("res://assets/ui/battle/stat_armor_boss_hovered.png")
				stat_displays[0][3].texture_pressed = load("res://assets/ui/battle/stat_armor_boss_hovered.png")
			stat_displays[0][0].text = "[left]" + str(int(display_creature.power)) + "\n" + str(int(display_creature.speed)) + "\n" + str(int(display_creature.armor)) + "/" + str(int(display_creature.max_armor))
			health_bars[0].max_value = display_creature.max_armor
			health_bars[0].value = display_creature.armor
			health_bars[0].tint_progress = Color.from_hsv(0.8, 1.0, 1.0)
		else:
			if stat_displays[0][3].id != 4:
				stat_displays[0][3].id = 4
				stat_displays[0][3].texture_normal = load("res://assets/ui/battle/stat_health_boss.png")
				stat_displays[0][3].texture_hover = load("res://assets/ui/battle/stat_health_boss_hovered.png")
				stat_displays[0][3].texture_pressed = load("res://assets/ui/battle/stat_health_boss_hovered.png")
			stat_displays[0][0].text = "[left]" + str(int(display_creature.power)) + "\n" + str(int(display_creature.speed)) + "\n" + str(int(display_creature.health)) + "/" + str(int(display_creature.max_health))
			health_bars[0].max_value = display_creature.max_health
			health_bars[0].value = display_creature.health
			health_bars[0].tint_progress = Color.from_hsv(1 - 0.2 * (health_bars[0].value / health_bars[0].max_value), 1.0, 1.0)
	else:
		if display_creature.max_armor:
			if stat_displays[0][3].id != 3:
				stat_displays[0][3].id = 3
				stat_displays[0][3].texture_normal = load("res://assets/ui/battle/stat_armor.png")
				stat_displays[0][3].texture_hover = load("res://assets/ui/battle/stat_armor_hovered.png")
				stat_displays[0][3].texture_pressed = load("res://assets/ui/battle/stat_armor_hovered.png")
			stat_displays[0][0].text = "[left]" + str(int(display_creature.power)) + "\n" + str(int(display_creature.speed)) + "\n" + str(int(display_creature.armor)) + "/" + str(int(display_creature.max_armor))
			health_bars[0].max_value = display_creature.max_armor
			health_bars[0].value = display_creature.armor
			health_bars[0].tint_progress = Color.from_hsv(0.15, 1.0, 1.0)
		else:
			if stat_displays[0][3].id != 2:
				stat_displays[0][3].id = 2
				stat_displays[0][3].texture_normal = load("res://assets/ui/battle/stat_health.png")
				stat_displays[0][3].texture_hover = load("res://assets/ui/battle/stat_health_hovered.png")
				stat_displays[0][3].texture_pressed = load("res://assets/ui/battle/stat_health_hovered.png")
			stat_displays[0][0].text = "[left]" + str(int(display_creature.power)) + "\n" + str(int(display_creature.speed)) + "\n" + str(int(display_creature.health)) + "/" + str(int(display_creature.max_health))
			health_bars[0].max_value = display_creature.max_health
			health_bars[0].value = display_creature.health
			health_bars[0].tint_progress = Color.from_hsv(0.35 * (health_bars[0].value / health_bars[0].max_value), 1.0, 1.0)
	first_stat_update = false

func display_summons():
	for i in battle_buttons.size():
		if i + page * 4 < all_creatures.size():
			var creature = all_creatures[i + page * 4]
			if creature.bound_talisman:
				battle_buttons[i].set_element_and_text(-1, "\t\t[color=#ff4dfa]" + creature.display_name + "[/color]")
				battle_buttons[i].set_talisman_texture(creature.bound_talisman.texture_path, creature.bound_talisman.level)
			else:
				battle_buttons[i].set_element_and_text(creature.element_id, "\t\t" + creature.display_name)
			battle_buttons[i].show()
		else:
			battle_buttons[i].hide()

func describe_element(_element_id: int):
	pass

func describe_stat(_stat_id: int):
	pass

func describe_button(_id: int):
	pass

func button_pressed(id: int):
	summon_creature(id + page * 4)
	update_names_and_stats()

func play_camera_anim(anim_name: String):
	anim.stop()
	$"Camera2D".offset = Vector2.ZERO
	$"Middle Box".self_modulate = Color.from_hsv(0.0, 0.0, 1.0)
	anim.play(anim_name)

func next_page():
	page += 1
	if page * 4 >= all_creatures.size():
		page = 0
	display_summons()
