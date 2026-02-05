class_name MeltingStatus extends BaseStatus

func _init() -> void:
	display_name = "Melting"
	descr = "Creatures on this side take 20% more damage from attacks, or 40% more if weak to Fire. Fire creatures are immune."
	element_id = elements["fire"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false

func extra_damage_intake_multipliers(_user: BaseCreature, target: BaseCreature, _move: BaseMove) -> float:
	if target.weak_to_type(element_id):
		return 1.4
	return 1.2
