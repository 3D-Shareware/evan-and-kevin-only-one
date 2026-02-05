class_name HardStatus extends BaseStatus

func _init() -> void:
	display_name = "Hard"
	descr = "This creature takes 50% less damage."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func extra_damage_intake_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	return 0.5
