class_name StormSpellMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 100
	accuracy = 100
	element_id = elements["water"]
	deals_damage = false
	kills_user = false
	move_name = "Storm Spell"
	move_animation = "Launch"
	descr = "Makes opposing terrain Flooded, Slick, and Misty."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	var suc1 = target.apply_status(FloodedStatus.new(), battle_properties)
	var suc2 = target.apply_status(MistyStatus.new(), battle_properties)
	var suc3 = target.apply_status(SlickStatus.new(), battle_properties)
	if suc1 and suc2 and suc3:
		return "A turbulent storm made " + target.display_name + "'s side Flooded, Slick, and Misty!"
	elif suc1 and suc2:
		return "A turbulent storm made " + target.display_name + "'s side Flooded and Misty!"
	elif suc1 and suc3:
		return "A turbulent storm made " + target.display_name + "'s side Flooded and Slick!" 
	elif suc2 and suc3:
		return "A turbulent storm made " + target.display_name + "'s side Misty and Slick!" 
	elif suc1:
		return "A turbulent storm made " + target.display_name + "'s side Flooded!"
	elif suc2:
		return "A turbulent storm made " + target.display_name + "'s side Misty!"
	elif suc3:
		return "A turbulent storm made " + target.display_name + "'s side Slick!" 
	else:
		return "[color=#ff1717]But nothing happened![/color]"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
