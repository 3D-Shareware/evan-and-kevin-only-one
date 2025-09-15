class_name TremorMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = true
	move_name = "Tremor"
	move_animation = "Stomp"
	descr = "If foe flinches or is weak to Earth, the opposing terrain becomes Rough."
