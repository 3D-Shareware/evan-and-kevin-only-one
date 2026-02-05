class_name InsidesOutMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["water"]
	deals_damage = false
	kills_user = false
	move_name = "Insides Out"
	move_animation = "Squash"
	descr = "Switches user's Health or Armor with its Power."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	var stored_power = user.power
	if user.armor:
		user.power = user.armor
		user.max_armor = stored_power
		user.armor = stored_power
		return user.display_name + " swapped Power and Armor!"
	else:
		user.power = user.health
		user.max_health = stored_power
		user.health = stored_power
		return user.display_name + " swapped Power and Health!"
