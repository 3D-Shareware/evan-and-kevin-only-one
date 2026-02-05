class_name PassOnMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 150
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = false
	kills_user = true
	move_name = "Pass On"
	move_animation = "Grow"
	descr = "The next creature user summons adds this creature's Power and Speed to their stats."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.health = 0
	user.armor = 0
	var pass_on = PassOnStatus.new()
	pass_on.stored_power = user.power
	pass_on.stored_speed = user.speed
	user.apply_status(pass_on, battle_properties)
	return "[color=#ff1717]" + user.display_name + " sent its teachings to the next generation![/color]"
