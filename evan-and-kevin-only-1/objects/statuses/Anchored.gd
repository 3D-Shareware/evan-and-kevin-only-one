class_name AnchoredStatus extends BaseStatus

func _init() -> void:
	display_name = "Anchored"
	descr = "This creature survives one fatal blow."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false
