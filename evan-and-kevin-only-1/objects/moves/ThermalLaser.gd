class_name ThermalLaserMove extends BaseMove

func _init() -> void:
	damage = 50
	action_speed = 100
	accuracy = 90
	element_id = elements["fire"]
	deals_damage = true
	kills_user = false
	move_name = "Thermal Laser"
	move_animation = "Launch"
	descr = "Foe is continuously hit by this move every turn until user or foe is defeated."

func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	target.apply_status(ThermalLaserStatus.new(), battle_properties)
	return user.display_name + " pointed a laser at " + str(target.display_name) + "!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
