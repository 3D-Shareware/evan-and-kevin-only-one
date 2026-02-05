class_name ImpactStatus extends BaseStatus

func _init() -> void:
	display_name = "Impact"
	descr = "This creature's first attack deals 50% more damage."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func extra_damage_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	lasts_one_turn = true
	return 1.5
