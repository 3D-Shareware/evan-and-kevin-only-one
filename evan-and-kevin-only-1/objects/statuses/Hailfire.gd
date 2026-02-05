class_name HailfireStatus extends BaseStatus

func _init() -> void:
	display_name = "Hailfire"
	descr = "Every turn, this creature takes damage from the foe equal to 50% of foe's Power, 50% more if weak to Ice."
	element_id = 0
	is_terrain = false
	tied_to_foe = true
	lasts_one_turn = false

func end_of_turn(user: BaseCreature, target: BaseCreature) -> String:
	if elements["ice"] in user.weaknesses:
		@warning_ignore("narrowing_conversion")
		return "[color=#fff700]" + target.display_name + " fired on " + str(user.display_name) + " for " + str(user.take_damage(0.75 * target.power, true)) + " damage![/color]"
	@warning_ignore("narrowing_conversion")
	return target.display_name + " fired on " + str(user.display_name) + " for " + str(user.take_damage(0.5 * target.power, true)) + " damage!"
