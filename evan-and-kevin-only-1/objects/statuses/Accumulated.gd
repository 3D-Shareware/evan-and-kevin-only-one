class_name AccumulatedStatus extends BaseStatus

func _init() -> void:
	display_name = "Accumulated"
	descr = "This creature's next Ice or Water attack deals 100% more damage."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func extra_damage_multipliers(_user: BaseCreature, _target: BaseCreature, move: BaseMove) -> float:
	if move.element_id == elements["ice"] or move.element_id == elements["water"]:
		lasts_one_turn = true
		return 2
	return 1
