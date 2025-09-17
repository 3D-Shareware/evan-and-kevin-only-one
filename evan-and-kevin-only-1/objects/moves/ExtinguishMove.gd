class_name ExtinguishMove extends BaseMove

func _init() -> void:
	damage = 150
	action_speed = 100
	accuracy = 60
	element_id = elements["water"]
	deals_damage = true
	move_name = "Extinguish"
	move_animation = "Launch"
	descr = "Instantly defeats Fire foes."

func on_hit(_user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> String:
	if target.element_id == elements["fire"]:
		target.health = 0
		return "[color=#fff700]Instant KO![/color]"
	return ""
