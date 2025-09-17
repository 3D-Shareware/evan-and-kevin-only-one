class_name RockLobMove extends BaseMove

func _init() -> void:
	damage = 135
	action_speed = 100
	accuracy = 75
	element_id = elements["earth"]
	deals_damage = true
	move_name = "Rock Lob"
	move_animation = "Launch"
	descr = ""
