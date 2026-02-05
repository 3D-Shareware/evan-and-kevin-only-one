class_name DrySpellMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 100
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = false
	kills_user = false
	move_name = "Dry Spell"
	move_animation = "Launch"
	descr = "Makes opposing terrain Glowing and Grounded."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	var suc1 = target.apply_status(GlowingStatus.new(), battle_properties)
	var suc2 = target.apply_status(GroundedStatus.new(), battle_properties)
	if suc1 and suc2:
		return "Dry sunglight made " + target.display_name + "'s side Glowing and Grounded!"
	elif suc1:
		return "Dry sunglight made " + target.display_name + "'s side Glowing!"
	elif suc2:
		return "Dry sunglight made " + target.display_name + "'s side Grounded!"
	else:
		return "[color=#ff1717]But nothing happened![/color]"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
