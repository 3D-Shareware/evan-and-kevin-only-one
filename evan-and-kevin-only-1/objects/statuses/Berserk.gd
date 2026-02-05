class_name BerserkStatus extends BaseStatus

func _init() -> void:
	display_name = "Berserk"
	descr = "This creature is limited to 2 random moves every turn."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false
