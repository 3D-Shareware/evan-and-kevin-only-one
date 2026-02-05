class_name ExplosiveStatus extends BaseStatus

func _init() -> void:
	display_name = "Explosive"
	descr = "When this creature is defeated, it deals damage equal to double its Power to the foe."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false
