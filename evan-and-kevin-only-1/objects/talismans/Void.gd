class_name VoidTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Void"
	texture_path = "void"
	descr = "This creature clears all terrains on their side when summoned."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	if battle_properties[user.team].size() > 0:
		for j in range(battle_properties[user.team].size() - 1, -1, -1):
			if battle_properties[user.team][j].is_terrain and !battle_properties[user.team][j].summon_boost:
				battle_properties[user.team].pop_at(j)
