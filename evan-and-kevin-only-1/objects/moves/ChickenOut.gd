class_name ChickenOutMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 150
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = false
	kills_user = true
	move_name = "Chicken Out"
	move_animation = "Retreat"
	descr = "Returns user and Talisman to inventory. Can only be used once."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if user.get_parent().teams[user.team].size() > 1:
		user.alive = false
		user.get_parent().teams[user.team].append(user)
		if user.bound_talisman:
			user.get_parent().talismans.append(user.bound_talisman)
		user.bound_talisman = null
		user.level = 1
		user.moveset.pop_at(user.moveset.find(self))
		user.reset_stats()
		user.invincible = true
		return "[color=#ff1717]" + user.display_name + " got out of here![/color]"
	else:
		user.animate_move("Miss")
		return "[color=#ff1717]But " + user.display_name + " had nowhere to run![/color]"

func ai_priority(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	return -100
