class_name JustifiedStatus extends BaseStatus

func _init() -> void:
	display_name = "Justified"
	descr = "This creature lost an ally last turn."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = true
