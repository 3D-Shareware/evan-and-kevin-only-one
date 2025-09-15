class_name IcicleMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["ice"]
	deals_damage = true
	move_name = "Icicle"
	move_animation = "Stomp"
	descr = "If foe flinches or is weak to Ice, the opposing terrain becomes Chilled."
