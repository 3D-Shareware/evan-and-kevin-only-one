class_name AnchorSlamMove extends BaseMove

func _init() -> void:
	damage = 130
	action_speed = 70
	accuracy = 90
	element_id = elements["water"]
	deals_damage = true
	kills_user = false
	move_name = "Anchor Slam"
	move_animation = "Stomp"
	descr = "User becomes Anchored, enduring the next fatal blow."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if user.apply_status(AnchoredStatus.new(), battle_properties):
		return user.display_name + " threw down an anchor!"
	return ""
