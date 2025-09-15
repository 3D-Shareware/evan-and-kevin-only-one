class_name PiercingVenomMove extends BaseMove

func _init() -> void:
	damage = 115
	action_speed = 100
	accuracy = 75
	element_id = elements["plague"]
	deals_damage = true
	move_name = "Piercing Venom"
	move_animation = "Melee"
	descr = "If foe flinches or is weak to Plague, the opposing terrain becomes Poisoned."
