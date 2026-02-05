class_name StrikingStatus extends BaseStatus

func _init() -> void:
	display_name = "Striking"
	descr = "This creature's first move always goes first and flinches the foe."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func extra_speed_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	lasts_one_turn = true
	return 1.0
