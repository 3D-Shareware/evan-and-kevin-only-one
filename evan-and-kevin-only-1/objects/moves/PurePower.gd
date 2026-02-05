class_name PurePowerMove extends BaseMove

func _init() -> void:
	damage = 135
	action_speed = 100
	accuracy = 70
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Pure Power"
	move_animation = "Melee"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Filtered."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(FilteredStatus.new(), battle_properties):
		return "Filtered " + target.display_name + "'s side!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(FilteredStatus.new(), battle_properties):
		return "Filtered " + target.display_name + "'s side!"
	return ""
