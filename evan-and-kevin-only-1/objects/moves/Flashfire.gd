class_name FlashfireMove extends BaseMove

func _init() -> void:
	damage = 60
	action_speed = 130
	accuracy = 80
	element_id = elements["fire"]
	deals_damage = true
	kills_user = false
	move_name = "Flashfire"
	move_animation = "Melee"
	descr = "Increases user's Power by 10%, or 20% if foe is weak to this move."

func on_hit(user: BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id):
		@warning_ignore("narrowing_conversion")
		user.power *= 1.2
		return "[color=#fff700]" + user.display_name + "'s Power increased by 20%![/color]"
	else:
		@warning_ignore("narrowing_conversion")
		user.power *= 1.1
		return user.display_name + "'s Power increased by 10%!"
