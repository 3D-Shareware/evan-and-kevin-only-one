class_name ChargedStatus extends BaseStatus

var stacks = 0

func _init() -> void:
	display_name = "Charged"
	descr = "This creature's next attack deals x2 damage and has x2 speed."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func extra_damage_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	lasts_one_turn = true
	return pow(2, stacks + 1)

func extra_speed_multipliers(_user: BaseCreature, _target: BaseCreature, move: BaseMove) -> float:
	if move.deals_damage:
		lasts_one_turn = true
		return pow(2, stacks + 1)
	return 1

func stack_up():
	stacks = min(stacks + 1, 2)
	display_name = "Charged x" + str(stacks + 1)
	descr = "This creature's next attack deals x" + str(stacks * 4) + " damage and has x" + str(stacks * 4) + " speed."
