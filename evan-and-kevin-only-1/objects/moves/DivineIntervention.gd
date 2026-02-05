class_name DivineInterventionMove extends BaseMove

func _init() -> void:
	damage = 100
	action_speed = 70
	accuracy = 25
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Divine Intervention"
	move_animation = "Divine"
	descr = "Instantly defeats the foe, and clears all terrain effects on foe's side."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.armor:
		return target.display_name + "'s Armor protects it!"
	else:
		target.health = 0
		if battle_properties[target.team].size() > 0:
			for j in range(battle_properties[target.team].size() - 1, -1, -1):
				if battle_properties[target.team][j].is_terrain and !battle_properties[target.team][j].summon_boost:
					battle_properties[target.team].pop_at(j)
		return "[color=#fff700]" + target.display_name + " was obliterated by the heavens![/color]"

func ai_priority(user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> int:
	if !user.armor and user.power < 4 * target.health:
		return 2
	return 0
