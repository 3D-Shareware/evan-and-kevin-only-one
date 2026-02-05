class_name ExtinguishMove extends BaseMove

func _init() -> void:
	damage = 150
	action_speed = 100
	accuracy = 70
	element_id = elements["water"]
	deals_damage = true
	kills_user = false
	move_name = "Extinguish"
	move_animation = "Launch"
	descr = "Instantly defeats Fire foes."

func on_hit(_user: BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if target.element_id == elements["fire"]:
		if target.armor == 0:
			target.health = 0
			return "[color=#fff700]" + target.display_name + " ran out of oxygen![/color]"
		return target.display_name + "'s Armor protects it!"
	return ""

func ai_priority(_user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> int:
	if target.element_id == elements["fire"] and !target.armor:
		return 7
	return 0
