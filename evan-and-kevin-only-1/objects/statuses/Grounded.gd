class_name GroundedStatus extends BaseStatus

func _init() -> void:
	display_name = "Grounded"
	descr = "Creatures on this side can't heal, and if weak to Earth, take damage when they try to heal. Earth is immune."
	element_id = elements["earth"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false
