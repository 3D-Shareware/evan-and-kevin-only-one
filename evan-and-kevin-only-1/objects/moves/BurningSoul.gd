class_name BurningSoulMove extends BaseMove

func _init() -> void:
	damage = 95
	action_speed = 100
	accuracy = 90
	element_id = elements["fire"]
	deals_damage = true
	kills_user = false
	move_name = "Burning Soul"
	move_animation = "Melee"
	descr = "If user has more Speed than foe, deals 50% more damage and opposing terrain becomes Scorching."

func get_move_specific_damage(user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> float:
	if user.speed > target.speed:
		return user.power * self.damage * 1.5
	return user.power * self.damage

func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if user.speed > target.speed and target.apply_status(ScorchingStatus.new(), battle_properties):
		return "Scorched " + target.display_name + "'s side!"
	return ""
