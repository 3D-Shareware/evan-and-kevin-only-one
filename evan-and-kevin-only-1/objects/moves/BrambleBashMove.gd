class_name BrambleBashMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = true
	move_name = "Bramble Bash"
	move_animation = "Melee"
	descr = "If foe flinches or is weak to Plant, the opposing terrain becomes Thorny."
