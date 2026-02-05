class_name RoughStatus extends BaseStatus

func _init() -> void:
	display_name = "Rough"
	descr = "Creatures on this side can't move faster than their Speed, or 50% of their Speed if weak to Earth. Earth is immune."
	element_id = elements["earth"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false
