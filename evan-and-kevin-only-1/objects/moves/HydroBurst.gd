class_name HydroBurstMove extends BaseMove

func _init() -> void:
	damage = 200
	action_speed = 130
	accuracy = 100
	element_id = elements["water"]
	deals_damage = true
	kills_user = true
	move_name = "Hydro Burst"
	move_animation = "Explode"
	descr = "Opposing terrain becomes Slick."

func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.health = 0
	user.armor = 0
	if target.apply_status(SlickStatus.new(), battle_properties):
		return "[color=#ff1717]" + user.display_name + " bursted![/color] " + target.display_name + "'s side got Slick!"
	return "[color=#ff1717]" + user.display_name + " bursted![/color]"
