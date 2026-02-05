class_name SafetyBubbleStatus extends BaseStatus

func _init() -> void:
	display_name = "Safety Bubble"
	descr = "This side can't have additional terrains applied to it."
	element_id = 0
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false
