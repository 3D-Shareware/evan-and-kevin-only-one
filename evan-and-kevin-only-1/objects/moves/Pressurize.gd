class_name PressurizeMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 150
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = false
	kills_user = true
	move_name = "Pressurize"
	move_animation = "Squash"
	descr = "User's Talisman is returned to inventory with +2 levels."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, talismans: Array) -> String:
	user.health = 0
	user.armor = 0
	if user.bound_talisman:
		user.bound_talisman.level += 2
		talismans.append(user.bound_talisman)
		return "[color=#ff1717]" + user.display_name + " compressed magic into its Talisman![/color]"
	else:
		return "[color=#ff1717]" + user.display_name + " had no Talisman to compress![/color]" 

func ai_priority(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	return -100
