class_name ChillingStatus extends BaseStatus

func _init() -> void:
	display_name = "Chilling"
	descr = "Creatures on this side can't deal damage greater than their Power, or 70% of their Power if weak to Ice. Ice is immune."
	element_id = elements["ice"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false
