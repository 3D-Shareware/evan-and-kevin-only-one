class_name FloodedStatus extends BaseStatus

func _init() -> void:
	display_name = "Flooded"
	descr = "Creatures on this side take 50% more damage from Water attacks, or 100% more if weak to Water. Water creatures are immune."
	element_id = elements["water"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false

func extra_damage_intake_multipliers(_user: BaseCreature, target: BaseCreature, move: BaseMove) -> float:
	if move.element_id == elements["water"]:
		if target.weak_to_type(element_id):
			return 2
		return 1.5
	return 1
