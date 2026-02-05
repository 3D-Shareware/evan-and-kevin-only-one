class_name DemonsFireMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 100
	accuracy = 100
	element_id = elements["fire"]
	deals_damage = false
	kills_user = false
	move_name = "Demon's Fire"
	move_animation = "Launch"
	descr = "Makes opposing terrain Scorching and Tortured."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	var suc1 = target.apply_status(ScorchingStatus.new(), battle_properties)
	var suc2 = target.apply_status(TorturedStatus.new(), battle_properties)
	if suc1 and suc2:
		return "Dark flames Scorched and Tortured " + target.display_name + "'s side!"
	elif suc1:
		return "Dark flames Scorched " + target.display_name + "'s side!"
	elif suc2:
		return "Dark flames Tortured " + target.display_name + "'s side!"
	else:
		return "[color=#ff1717]But nothing happened![/color]"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
