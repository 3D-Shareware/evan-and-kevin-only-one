class_name JusticeMove extends BaseMove

func _init() -> void:
	damage = 95
	action_speed = 100
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	move_name = "Justice"
	move_animation = "Melee"
	descr = "Deals double damage if an ally was defeated last turn."

func get_damage(user: BaseCreature, _target: BaseCreature, battle_properties: Array) -> int:
	if "just_lost_ally" in battle_properties[user.team]:
		return user.power * self.damage * 2
	return user.power * self.damage

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array) -> String:
	if "just_lost_ally" in battle_properties[user.team]:
		return "[color=#fff700]Justice served![/color]"
	return ""
