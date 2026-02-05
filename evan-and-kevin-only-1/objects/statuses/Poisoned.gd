class_name PoisonedStatus extends BaseStatus

func _init() -> void:
	display_name = "Poisoned"
	descr = "Every turn, creatures on this side lose 10% of their Health, or 20% if weak to Plague. Plague creatures are immune."
	element_id = elements["plague"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false

func end_of_turn(user: BaseCreature, _target: BaseCreature) -> String:
	if user.armor > 0:
		return ""
	if user.weak_to_type(element_id):
		@warning_ignore("narrowing_conversion")
		return "[color=#fff700]" + user.display_name + " inhaled toxins and took " + str(user.take_damage(0.2 * user.max_health, false)) + " damage![/color]"
	@warning_ignore("narrowing_conversion")
	return user.display_name + " inhaled toxins and took " + str(user.take_damage(0.1 * user.max_health, false)) + " damage!"
