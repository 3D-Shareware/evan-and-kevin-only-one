class_name DownpourMove extends BaseMove

func _init() -> void:
	damage = 110
	action_speed = 100
	accuracy = 100
	element_id = elements["water"]
	deals_damage = true
	kills_user = false
	move_name = "Downpour"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Flooded."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(FloodedStatus.new(), battle_properties):
		return "Flooded " + target.display_name + "'s side!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(FloodedStatus.new(), battle_properties):
		return "Flooded " + target.display_name + "'s side!"
	return ""
