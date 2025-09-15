class_name BanefulStrikeMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 90
	element_id = elements["plague"]
	deals_damage = true
	move_name = "Baneful Strike"
	move_animation = "Melee"
	descr = "If foe flinches or is weak to Plague, the opposing terrain becomes Tortured."
