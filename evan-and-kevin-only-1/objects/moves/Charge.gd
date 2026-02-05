class_name ChargeMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = false
	kills_user = false
	move_name = "Charge"
	move_animation = "Squash"
	descr = "User's next attack deals double damage and has double speed. Can stack up to 3 times."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	for i in battle_properties[user.team]:
		if i.display_name == "Charged x3":
			return "[color=#ff4dfa]" + user.display_name + " is fully charged![/color]"
		elif i.display_name == "Charged x2":
			i.stack_up()
			return "[color=#ff4dfa]" + user.display_name + " is fully charged![/color]"
		elif i.display_name == "Charged":
			i.stack_up()
			return "[color=#fff700]" + user.display_name + " is really charging![/color]"
	user.apply_status(ChargedStatus.new(), battle_properties)
	return user.display_name + " is charging!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
