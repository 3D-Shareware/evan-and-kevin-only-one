class_name SavingGraceMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 150
	accuracy = 100
	element_id = elements["light"]
	deals_damage = false
	kills_user = false
	move_name = "Saving Grace"
	move_animation = "Grow"
	descr = "Clears all terrains from the user's side."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	for i in range(battle_properties[user.team].size() - 1, -1, -1):
		if battle_properties[user.team][i].is_terrain and !battle_properties[user.team][i].display_name == "Safety Bubble":
			battle_properties[user.team].pop_at(i)
	return user.display_name + " cleansed its side!"

## Returns priority modifiers for special moves like Slush that need smart AI to use.
func ai_priority(user: BaseCreature, _target: BaseCreature, battle_properties: Array) -> int:
	var active_terrains = 0
	for i in battle_properties[user.team]:
		if i.is_terrain:
			active_terrains += 1
	if active_terrains >= 3:
		return 15
	elif active_terrains > 0:
		return 0
	return -1
