class_name LashOutMove extends BaseMove

func _init() -> void:
	damage = 50
	action_speed = 150
	accuracy = 100
	element_id = elements["plague"]
	deals_damage = true
	move_name = "Lash Out"
	move_animation = "Melee"
	descr = ""
