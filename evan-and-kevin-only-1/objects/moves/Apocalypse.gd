class_name ApocalypseMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plague"]
	deals_damage = false
	kills_user = false
	move_name = "Apocalypse"
	move_animation = "Darkness"
	descr = "[color=#ff1717]Defeats all of user's allies.[/color] For every ally this move defeats, all of user's stats increase by 20%, and user's Health is fully healed."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	var user_team = user.get_parent().teams[user.team]
	var allies_absorbed = 0
	if user_team.size() > 1:
		for j in range(user_team.size() - 1, 0, -1):
			user_team.pop_at(j)
			allies_absorbed += 1
		var absorption_multiplier = 1 + (allies_absorbed * 0.2)
		@warning_ignore("narrowing_conversion")
		user.max_health *= absorption_multiplier
		@warning_ignore("narrowing_conversion")
		user.health *= absorption_multiplier
		@warning_ignore("narrowing_conversion")
		user.max_armor *= absorption_multiplier
		@warning_ignore("narrowing_conversion")
		user.armor *= absorption_multiplier
		@warning_ignore("narrowing_conversion")
		user.power *= absorption_multiplier
		@warning_ignore("narrowing_conversion")
		user.speed *= absorption_multiplier
		return "[color=#ff1717]" + user.display_name + " absorbed the life of its allies![/color] Increased all stats by " + str(allies_absorbed * 20) + "%! Healed " + str(user.heal_damage(user.max_health)) + " Health!"
	return "[color=#ff1717]But " + user.display_name + " had no allies to absorb![/color]"
