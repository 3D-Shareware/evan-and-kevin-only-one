class_name StoneThrowMove extends BaseMove

func _init() -> void:
	damage = 60
	action_speed = 130
	accuracy = 90
	element_id = elements["earth"]
	deals_damage = true
	kills_user = false
	move_name = "Stone Throw"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Grounded."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(GroundedStatus.new(), battle_properties):
		return "Grounded " + target.display_name + "'s side!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(GroundedStatus.new(), battle_properties):
		return "Grounded " + target.display_name + "'s side!"
	return ""
