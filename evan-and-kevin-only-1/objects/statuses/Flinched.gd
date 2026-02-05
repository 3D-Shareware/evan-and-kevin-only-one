class_name FlinchedStatus extends BaseStatus

func _init() -> void:
	display_name = "Flinched"
	descr = "This creature cannot move for the turn."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = true
