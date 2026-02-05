extends Node

enum scenes {overworld, battle}

var scene_collection = [preload("res://levels/overworld.tscn"), preload("res://levels/battle.tscn")]

var difficulty = 0
var turns = -1
var boss_phases = []
var teams = [[], []]
var enemies = []
var talismans = []
var battle_rewards = []
var known_phases = 0
var boss_fight = false

var current_scene: Node

func _ready() -> void:
	change_scene(scenes["overworld"])

func change_scene(scene_id: int):
	if scene_id == scenes["overworld"]:
		turns += 1
	
	if current_scene != null:
		current_scene.queue_free()
	var new_scene = scene_collection[scene_id].instantiate()
	add_child(new_scene)
	current_scene = new_scene

func set_up_game():
	set_up_final_boss()
	change_scene(scenes["overworld"])

func set_up_final_boss():
	var final_boss_phase_choices = [1, 2, 3, 4, 5, 6, 7]
	for i in difficulty:
		var rng = randi_range(0, final_boss_phase_choices.size() - 1)
		boss_phases.append(final_boss_phase_choices[rng])
		final_boss_phase_choices.pop_at(rng)
	boss_phases.append(0)

func award_rewards():
	if battle_rewards:
		if enemies:
			for i in enemies:
				current_scene.remove_child(i)
				i.bound_talisman = null
				i.ready_element()
				i.level_up(1)
				teams[0].append(i)
		for i in battle_rewards:
			i.add_reward(self)

func initiate_battle(boss_fight_time: bool):
	boss_fight = boss_fight_time
	if boss_fight:
		teams[1] = []
	else:
		teams[1] = enemies.duplicate(true)
	change_scene(scenes["battle"])
