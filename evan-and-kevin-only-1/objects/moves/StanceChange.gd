class_name StanceChangeMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["fire"]
	deals_damage = false
	kills_user = false
	move_name = "Stance Change"
	move_animation = "Grow"
	descr = "Changes user's stance, switching its Power and Speed, then increasing both by 20%."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	@warning_ignore("narrowing_conversion")
	user.power *= 1.2
	@warning_ignore("narrowing_conversion")
	user.speed *= 1.2
	var stored_power = user.power
	user.power = user.speed
	user.speed = stored_power
	if user.has_method("change_stance"):
		user.change_stance()
	return user.display_name + "'s Power and Speed increased by 20%! Swapped Power and Speed!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
