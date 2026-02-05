class_name LightspeedMove extends BaseMove

func _init() -> void:
	damage = 30
	action_speed = 150
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Lightspeed"
	move_animation = "Melee"
	descr = "Increases user's Speed by 10%, or 20% if foe is weak to this move."

func on_hit(user: BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id):
		@warning_ignore("narrowing_conversion")
		user.speed *= 1.2
		return "[color=#fff700]" + user.display_name + "'s Speed increased by 20%![/color]"
	else:
		@warning_ignore("narrowing_conversion")
		user.speed *= 1.1
		return user.display_name + "'s Speed increased by 10%!"
