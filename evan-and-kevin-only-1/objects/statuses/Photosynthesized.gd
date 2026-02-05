class_name PhotosynthesizedStatus extends BaseStatus

func _init() -> void:
	display_name = "Photosynthesized"
	descr = "This creature's next Light attack deals 100% more damage."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func extra_damage_multipliers(_user: BaseCreature, _target: BaseCreature, move: BaseMove) -> float:
	if move.element_id == elements["light"]:
		lasts_one_turn = true
		return 2
	return 1
