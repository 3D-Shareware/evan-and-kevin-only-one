class_name FlashfireMove extends BaseMove

func _init() -> void:
	damage = 80
	action_speed = 150
	accuracy = 80
	element_id = elements["fire"]
	deals_damage = true
	move_name = "Flashfire"
	move_animation = "Melee"
	descr = "This move hurts!"
