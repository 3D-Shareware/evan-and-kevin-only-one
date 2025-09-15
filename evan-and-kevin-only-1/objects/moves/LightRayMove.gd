class_name LightRayMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	move_name = "Light Ray"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to Light, the opposing terrain becomes Blinding."
