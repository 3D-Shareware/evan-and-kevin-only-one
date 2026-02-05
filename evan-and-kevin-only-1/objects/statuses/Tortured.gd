class_name TorturedStatus extends BaseStatus

func _init() -> void:
	display_name = "Tortured"
	descr = "Creatures that take damage on this side take an additional 5% of their max Health in damage, or 10% if weak to Plague. Plague is immune."
	element_id = elements["plague"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false
