class_name CrashingWaveMove extends BaseMove

func _init() -> void:
	damage = 95
	action_speed = 150
	accuracy = 100
	element_id = elements["water"]
	deals_damage = true
	kills_user = false
	move_name = "Crashing Wave"
	move_animation = "Melee"
	descr = "Makes the opposing terrain Slick, but cuts user's Speed by 30%."

func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	@warning_ignore("narrowing_conversion")
	user.speed *= 0.7
	if target.apply_status(SlickStatus.new(), battle_properties):
		return target.display_name + "'s side got Slick! " + user.display_name + "'s Speed cut by 30%!"
	return user.display_name + "'s Speed cut by 30%!"
