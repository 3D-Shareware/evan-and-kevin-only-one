class_name PlunderMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["water"]
	deals_damage = false
	kills_user = false
	move_name = "Plunder"
	move_animation = "Grow"
	descr = "User finds a random Talisman and puts it in inventory. The higher the user's level, the better the luck. Yo ho!"

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, talismans: Array) -> String:
	var all_talismans = [
		AimingTalisman, AnchoringTalisman, BerserkTalisman, EtherTalisman, ExplosiveTalisman, ImpactTalisman,
		RegenerativeTalisman, SimpleTalisman, SteadfastTalisman, StrikingTalisman, VoidTalisman, WeirdTalisman
	]
	var new_talisman = all_talismans[randi_range(0, all_talismans.size() - 1)].new()
	var rng = 0
	for i in user.level:
		var new_rng = randf()
		rng = max(new_rng, rng)
	if rng > 0.99:
		new_talisman.level = 6
	elif rng > 0.96:
		new_talisman.level = 5
	elif rng > 0.9:
		new_talisman.level = 4
	elif rng > 0.7:
		new_talisman.level = 3
	elif rng > 0.4:
		new_talisman.level = 2
	else:
		new_talisman.level = 1
	talismans.append(new_talisman)
	if new_talisman.level == 1:
		return "Yarrgh! " + user.display_name + " found ye Lv. " + str(new_talisman.level) + " " + new_talisman.display_name + " Talisman!"
	elif new_talisman.level == 2:
		return "Ahoy! " + user.display_name + " found ye ol' Lv. " + str(new_talisman.level) + " " + new_talisman.display_name + " Talisman!"
	elif new_talisman.level == 3:
		return "[color=#fff700]Booty![/color] " + user.display_name + " found ye rare Lv. " + str(new_talisman.level) + " " + new_talisman.display_name + " Talisman!"
	return "[color=#ff4dfa]Shiver me timbers![/color] " + user.display_name + " found ye legendary Lv. " + str(new_talisman.level) + " " + new_talisman.display_name + " Talisman!"

func ai_priority(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	return -100
