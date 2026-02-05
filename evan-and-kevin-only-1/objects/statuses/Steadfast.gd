class_name SteadfastStatus extends BaseStatus

func _init() -> void:
	display_name = "Steadfast"
	descr = "This creature cannot flinch."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false
