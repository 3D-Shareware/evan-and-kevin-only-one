class_name LightspeedMove extends BaseMove

func _init() -> void:
	damage = 50
	action_speed = 150
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	move_name = "Lightspeed"
	move_animation = "Melee"
	descr = "Increases user's Speed by 10%."
