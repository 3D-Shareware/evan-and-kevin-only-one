class_name ScorchingStatus extends BaseStatus

func _init() -> void:
	display_name = "Scorching"
	descr = "Creatures on this side take 20% of the damage of their own attacks, or 40% if weak to Fire. Fire creatures are immune."
	element_id = elements["fire"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false

func deal_damage(user: BaseCreature, _target: BaseCreature, damage: int) -> String:
	if user.armor > 0:
		return ""
	else:
		if user.weak_to_type(element_id):
			@warning_ignore("narrowing_conversion")
			return "[color=#fff700]" + user.display_name + " scorched itself and took " + str(user.take_damage(damage * 0.4, false)) + " damage![/color]"
		@warning_ignore("narrowing_conversion")
		return user.display_name + " scorched itself and took " + str(user.take_damage(damage * 0.2, false)) + " damage!"
