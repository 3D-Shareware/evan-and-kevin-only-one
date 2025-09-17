class_name SubzeroSlashMove extends BaseMove

func _init() -> void:
	damage = 110
	action_speed = 100
	accuracy = 80
	element_id = elements["ice"]
	deals_damage = true
	move_name = "Subzero Slash"
	move_animation = "Melee"
	descr = "Reduces foe's Speed by 30%, doubled if foe is weak to Ice."

func on_hit(_user:BaseCreature, target: BaseCreature, _battle_properties: Array) -> String:
	if elements["ice"] in target.weaknesses:
		@warning_ignore("narrowing_conversion")
		target.speed = max(target.speed * 0.4, 1)
		return "[color=#fff700]" + target.display_name + "'s Speed cut by 60%![/color]"
	else:
		@warning_ignore("narrowing_conversion")
		target.speed = max(target.speed * 0.7, 1)
		return target.display_name + "'s Speed cut by 30%!"
