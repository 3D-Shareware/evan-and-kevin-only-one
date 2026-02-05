class_name SappedStatus extends BaseStatus

func _init() -> void:
	display_name = "Sapped"
	descr = "Creatures that take damage on this side heal the other side for 25% of damage taken, or 50% if weak to Plant. Plant is immune."
	element_id = elements["plant"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false
