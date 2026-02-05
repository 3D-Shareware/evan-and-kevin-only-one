class_name WeirdStatus extends BaseStatus

func _init() -> void:
	display_name = "Weird"
	descr = "Every turn, a random one of this creature's stats are increased by 20%."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func end_of_turn(user: BaseCreature, _target: BaseCreature) -> String:
	var rand_stat = randi_range(1, 3)
	if rand_stat == 1:
		if user.armor:
			@warning_ignore("narrowing_conversion")
			user.max_armor *= 1.2
			@warning_ignore("narrowing_conversion")
			user.armor *= 1.2
			return user.display_name + "'s Armor and max Armor increased by 20%!"
		else:
			@warning_ignore("narrowing_conversion")
			user.max_health *= 1.2
			@warning_ignore("narrowing_conversion")
			user.health *= 1.2
			return user.display_name + "'s Health and max Health increased by 20%!"
	elif rand_stat == 2:
		@warning_ignore("narrowing_conversion")
		user.power *= 1.2
		return user.display_name + "'s Power increased by 20%!"
	else:
		@warning_ignore("narrowing_conversion")
		user.speed *= 1.2
		return user.display_name + "'s Speed increased by 20%!"
