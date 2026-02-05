class_name FunkyTonicMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plague"]
	deals_damage = false
	kills_user = false
	move_name = "Funky Tonic"
	move_animation = "Grow"
	descr = "Increases a random stat of the user's by 50%."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	var rand_stat = randi_range(1, 3)
	if rand_stat == 1:
		if user.armor:
			@warning_ignore("narrowing_conversion")
			user.max_armor *= 1.5
			@warning_ignore("narrowing_conversion")
			user.armor *= 1.5
			return "Get a whiff of this! " + user.display_name + "'s Armor and max Armor increased by 50%!"
		else:
			@warning_ignore("narrowing_conversion")
			user.max_health *= 1.5
			@warning_ignore("narrowing_conversion")
			user.health *= 1.5
			return "Get a whiff of this! " + user.display_name + "'s Health and max Health increased by 50%!"
	elif rand_stat == 2:
		@warning_ignore("narrowing_conversion")
		user.power *= 1.5
		return "Get a whiff of this! " + user.display_name + "'s Power increased by 50%!"
	else:
		@warning_ignore("narrowing_conversion")
		user.speed *= 1.5
		return "Get a whiff of this! " + user.display_name + "'s Speed increased by 50%!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
