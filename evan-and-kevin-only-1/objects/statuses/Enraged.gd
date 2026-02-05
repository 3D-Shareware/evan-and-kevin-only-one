class_name EnragedStatus extends BaseStatus

var stacks = 4

func _init() -> void:
	display_name = "Enraged"
	descr = "This creature has 4 turns to live."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func end_of_turn(user: BaseCreature, _target: BaseCreature) -> String:
	stacks = max(0, stacks - 1)
	if stacks <= 0:
		descr = "Time has run out!"
		user.health = 0
		user.armor = 0
		return "[color=#ff1717]" + user.display_name + "'s time has run out![/color]"
	if stacks == 1:
		descr = "This creature has 1 turn to live."
		return user.display_name + " has 1 turn to live!"
	else:
		descr = "This creature has " + str(stacks) + " turns to live."
		return user.display_name + " has " + str(stacks) + " turns to live!"
