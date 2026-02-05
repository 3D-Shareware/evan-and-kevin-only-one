class_name GlowingStatus extends BaseStatus

func _init() -> void:
	display_name = "Glowing"
	descr = "Creatures on opposite side have 50% more accuracy, or 100% if this creature is weak to Light. Light is immune."
	element_id = elements["light"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false

func extra_accuracy_intake_multipliers(_user: BaseCreature, target: BaseCreature, _move: BaseMove) -> float:
	if target.weak_to_type(element_id):
		return 2
	return 1.5
