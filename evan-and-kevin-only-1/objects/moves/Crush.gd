class_name CrushMove extends BaseMove

func _init() -> void:
	damage = 110
	action_speed = 100
	accuracy = 80
	element_id = elements["earth"]
	deals_damage = true
	kills_user = false
	move_name = "Crush"
	move_animation = "Stomp"
	descr = "Reduces foe's Power by 30%, or 60% if foe is weak to this move."

func on_hit(_user:BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id):
		@warning_ignore("narrowing_conversion")
		target.power = max(target.power * 0.4, 1)
		return "[color=#fff700]" + target.display_name + "'s Power cut by 60%![/color]"
	else:
		@warning_ignore("narrowing_conversion")
		target.power = max(target.power * 0.7, 1)
		return target.display_name + "'s Power cut by 30%!"
