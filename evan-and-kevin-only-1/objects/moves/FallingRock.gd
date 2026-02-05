class_name FallingRockMove extends BaseMove

func _init() -> void:
	damage = 160
	action_speed = 100
	accuracy = 60
	element_id = elements["earth"]
	deals_damage = true
	kills_user = false
	move_name = "Falling Rock"
	move_animation = "Launch"
	descr = "Deals damage."
