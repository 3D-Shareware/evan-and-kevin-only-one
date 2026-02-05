class_name ThousandYearsMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = false
	kills_user = false
	move_name = "Thousand Years"
	move_animation = "Squash"
	descr = "Increases user's Power and Speed by 10% every turn."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.apply_status(ThousandYearsStatus.new(), battle_properties)
	return user.display_name + " started aging!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
