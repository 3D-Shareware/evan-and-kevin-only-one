class_name BrambleBashMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = true
	kills_user = false
	move_name = "Bramble Bash"
	move_animation = "Melee"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Thorny."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(ThornyStatus.new(), battle_properties):
		return "Made " + target.display_name + "'s side Thorny!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(ThornyStatus.new(), battle_properties):
		return "Made " + target.display_name + "'s side Thorny!"
	return ""
