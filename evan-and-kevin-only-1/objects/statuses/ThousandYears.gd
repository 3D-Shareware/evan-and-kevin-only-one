class_name ThousandYearsStatus extends BaseStatus

func _init() -> void:
	display_name = "Thousand Years"
	descr = "Every turn, this creature's Power and Speed increases by 10%."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func end_of_turn(user: BaseCreature, _target: BaseCreature) -> String:
	@warning_ignore("narrowing_conversion")
	user.power *= 1.1
	@warning_ignore("narrowing_conversion")
	user.speed *= 1.1
	return user.display_name + " ages! Power and Speed increased by 10%!"
