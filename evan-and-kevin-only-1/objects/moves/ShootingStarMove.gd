class_name ShootingStarMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	move_name = "Shooting Star"
	move_animation = "Melee"
	descr = "This move hurts!"
