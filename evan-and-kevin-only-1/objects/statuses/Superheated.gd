class_name SuperheatedStatus extends BaseStatus

func _init() -> void:
	display_name = "Superheated"
	descr = "This creature's Fire attacks deal 50% more damage, or 100% to foes weak to Fire."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func extra_damage_multipliers(_user: BaseCreature, target: BaseCreature, move: BaseMove) -> float:
	if move.element_id == elements["fire"]:
		if target.weak_to_type(move.element_id):
			return 2
		return 1.5
	return 1
