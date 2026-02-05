class_name SmogMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 100
	accuracy = 100
	element_id = elements["ice"]
	deals_damage = false
	kills_user = false
	move_name = "Smog"
	move_animation = "Launch"
	descr = "Makes opposing terrain Poisoned and Misty."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	var suc1 = target.apply_status(PoisonedStatus.new(), battle_properties)
	var suc2 = target.apply_status(MistyStatus.new(), battle_properties)
	if suc1 and suc2:
		return "Poison and Mist swirled around " + target.display_name + "'s side!"
	elif suc1:
		return "Poison swirled around " + target.display_name + "'s side!"
	elif suc2:
		return "Mist swirled around " + target.display_name + "'s side!"
	else:
		return "[color=#ff1717]But nothing happened![/color]"
