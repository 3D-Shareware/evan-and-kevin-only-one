class_name SuperheatMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["fire"]
	deals_damage = false
	kills_user = false
	move_name = "Superheat"
	move_animation = "Squash"
	descr = "Superheats user, boosting damage of user's Fire attacks by 50%, or 100% to foes weak to Fire."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if user.apply_status(SuperheatedStatus.new(), battle_properties):
		return user.display_name + " got heated!"
	return "[color=#ff1717]But " + user.display_name + " is already heated![/color]"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
