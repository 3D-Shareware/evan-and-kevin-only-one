class_name FilteredStatus extends BaseStatus

func _init() -> void:
	display_name = "Filtered"
	descr = "Creatures on this side can't use status moves, and if they're weak to Light, lose 30% of their Health when they try. Light is immune."
	element_id = elements["light"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false
