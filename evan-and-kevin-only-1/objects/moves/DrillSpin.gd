class_name DrillSpinMove extends BaseMove

func _init() -> void:
	damage = 75
	action_speed = 100
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = true
	kills_user = false
	move_name = "Drill Spin"
	move_animation = "Melee"
	descr = "Increases user's Power by 25%, or 50% if foe is weak to this move."

func on_hit(user: BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id):
		@warning_ignore("narrowing_conversion")
		user.power *= 1.5
		return "[color=#fff700]" + user.display_name + "'s Power increased by 50%![/color]"
	else:
		@warning_ignore("narrowing_conversion")
		user.power *= 1.25
		return user.display_name + "'s Power increased by 25%!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
