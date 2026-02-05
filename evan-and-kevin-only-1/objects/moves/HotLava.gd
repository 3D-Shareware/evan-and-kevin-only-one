class_name HotLavaMove extends BaseMove

func _init() -> void:
	damage = 110
	action_speed = 100
	accuracy = 75
	element_id = elements["fire"]
	deals_damage = true
	kills_user = false
	move_name = "Hot Lava"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Melting."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(MeltingStatus.new(), battle_properties):
		return target.display_name + "'s side started Melting!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(MeltingStatus.new(), battle_properties):
		return target.display_name + "'s side started Melting!"
	return ""
