class_name IcicleMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["ice"]
	deals_damage = true
	kills_user = false
	move_name = "Icicle"
	move_animation = "Stomp"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Chilling."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(ChillingStatus.new(), battle_properties):
		return "Chilled " + target.display_name + "'s side!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(ChillingStatus.new(), battle_properties):
		return "Chilled " + target.display_name + "'s side!"
	return ""
