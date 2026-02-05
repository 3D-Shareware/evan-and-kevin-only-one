class_name SafetyBubbleMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["water"]
	deals_damage = false
	kills_user = false
	move_name = "Safety Bubble"
	move_animation = "Grow"
	descr = "Protects user's side from having additional terrains applied to it."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.apply_status(SafetyBubbleStatus.new(), battle_properties)
	return "A bubble surrounds " + user.display_name + "'s side!"

## Returns priority modifiers for special moves like Slush that need smart AI to use.
func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if user.turns_alive == 0:
		return 100
	return 0
