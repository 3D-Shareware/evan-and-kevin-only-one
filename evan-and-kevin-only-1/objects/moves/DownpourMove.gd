class_name DownpourMove extends BaseMove

func _init() -> void:
	damage = 110
	action_speed = 100
	accuracy = 100
	element_id = elements["water"]
	deals_damage = true
	move_name = "Downpour"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to Water, the opposing terrain becomes Slick."
