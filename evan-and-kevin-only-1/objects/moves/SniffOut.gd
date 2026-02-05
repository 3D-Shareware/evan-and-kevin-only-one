class_name SniffOutMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = false
	kills_user = false
	move_name = "Sniff Out"
	move_animation = "Grow"
	descr = "User finds a Talisman identical to its own and puts it in inventory. Can only be used once."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, talismans: Array) -> String:
	if user.bound_talisman:
		talismans.append(user.bound_talisman)
		user.moveset.pop_at(user.moveset.find(self))
		return user.display_name + " sniffed out another Lv. " + str(user.bound_talisman.level) + " " + user.bound_talisman.display_name + " Talisman!"
	else:
		return "[color=#ff1717]But " + user.display_name + " had no Talisman to find![/color]" 

func ai_priority(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	return -100
