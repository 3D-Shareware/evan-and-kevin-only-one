class_name CombustMove extends BaseMove

func _init() -> void:
	damage = 160
	action_speed = 130
	accuracy = 100
	element_id = elements["fire"]
	deals_damage = true
	kills_user = true
	move_name = "Combust"
	move_animation = "Explode"
	descr = "Opposing terrain becomes Scorching."

func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.health = 0
	user.armor = 0
	if target.apply_status(ScorchingStatus.new(), battle_properties):
		return "[color=#ff1717]" + user.display_name + " went up in flames![/color] Scorched " + target.display_name + "'s side!"
	return "[color=#ff1717]" + user.display_name + " went up in flames![/color]"
