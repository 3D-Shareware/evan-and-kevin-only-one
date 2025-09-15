class_name TimberMove extends BaseMove

func _init() -> void:
	damage = 115
	action_speed = 100
	accuracy = 85
	element_id = elements["plant"]
	deals_damage = true
	move_name = "Timber"
	move_animation = "Stomp"
	descr = "If foe flinches or is weak to Plant, the opposing terrain becomes Sapped."
