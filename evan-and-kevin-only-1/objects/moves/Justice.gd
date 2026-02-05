class_name JusticeMove extends BaseMove

func _init() -> void:
	damage = 95
	action_speed = 100
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Justice"
	move_animation = "Melee"
	descr = "Deals double damage if an ally was defeated last turn."

func get_move_specific_damage(user: BaseCreature, _target: BaseCreature, battle_properties: Array) -> float:
	for i in battle_properties[user.team]:
		if i.display_name == "Justified":
			return user.power * self.damage * 2
	return user.power * self.damage

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	for i in battle_properties[user.team]:
		if i.display_name == "Justified":
			return "[color=#fff700]Justice served![/color]"
	return ""

func ai_priority(user: BaseCreature, _target: BaseCreature, battle_properties: Array) -> int:
	for i in battle_properties[user.team]:
		if i.display_name == "Justified":
			return 7
	return 0
