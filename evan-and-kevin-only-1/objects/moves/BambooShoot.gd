class_name BambooShootMove extends BaseMove

func _init() -> void:
	damage = 70
	action_speed = 130
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = true
	kills_user = false
	move_name = "Bamboo Shoot"
	move_animation = "Melee"
	descr = "Deals damage."
