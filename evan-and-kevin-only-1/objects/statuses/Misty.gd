class_name MistyStatus extends BaseStatus

func _init() -> void:
	display_name = "Misty"
	descr = "Creatures on this side have 25% less accuracy, or 50% less if weak to Ice. Ice is immune."
	element_id = elements["ice"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false

func extra_accuracy_multipliers(user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	if user.weak_to_type(element_id):
		return 0.5
	return 0.75
