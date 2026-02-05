class_name ThornsFirstMove extends BaseMove

func _init() -> void:
	damage = 125
	action_speed = 150
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = true
	kills_user = false
	move_name = "Thorns First"
	move_animation = "Melee"
	descr = "If foe prepares an attack, goes first, flinches foe, and makes opposing side Thorny. Otherwise, it fails and user loses 50% Health."

func always_goes_first(user: BaseCreature, target: BaseCreature, moves: Array) -> bool:
	if user.team == 0:
		user.get_parent().player_parried_last_turn = true
	if moves[target.team].deals_damage:
		failing = false
		return true
	failing = true
	return false

## What the move does if it doesn't miss the foe.
func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if failing:
		@warning_ignore("narrowing_conversion")
		return "[color=#ff1717]But " + user.display_name + " foresaw nothing! Took " + str(user.take_damage(user.max_health * 0.5, true)) + " damage![/color]"
	else:
		if !target.max_armor:
			target.apply_status(FlinchedStatus.new(), battle_properties)
		if target.apply_status(ThornyStatus.new(), battle_properties):
			return user.display_name + " foresaw " + target.display_name + "'s attack! Made " + target.display_name + "'s side Thorny!"
		else:
			return user.display_name + " foresaw " + target.display_name + "'s attack!"

func on_fail(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if user.boss:
		@warning_ignore("narrowing_conversion")
		return "[color=#ff1717]But " + user.display_name + " foresaw nothing! Took " + str(user.take_damage(user.max_health * 0.25, true)) + " damage![/color]"
	else:
		@warning_ignore("narrowing_conversion")
		return "[color=#ff1717]But " + user.display_name + " foresaw nothing! Took " + str(user.take_damage(user.max_health * 0.5, true)) + " damage![/color]"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
