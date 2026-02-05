class_name SlickStatus extends BaseStatus

func _init() -> void:
	display_name = "Slick"
	descr = "Creatures on this side that go first take damage equal to 50% of their move's speed, or 100% if weak to Water. Water is immune."
	element_id = elements["water"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false
