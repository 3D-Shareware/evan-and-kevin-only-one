class_name LightRayMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Light Ray"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Glowing."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(GlowingStatus.new(), battle_properties):
		return target.display_name + "'s side started Glowing!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(GlowingStatus.new(), battle_properties):
		return target.display_name + "'s side started Glowing!"
	return ""

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
