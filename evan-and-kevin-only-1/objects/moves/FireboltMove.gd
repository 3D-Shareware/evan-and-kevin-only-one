class_name FireboltMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 90
	element_id = elements["fire"]
	deals_damage = true
	move_name = "Firebolt"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to Fire, the opposing terrain becomes Scorched."
