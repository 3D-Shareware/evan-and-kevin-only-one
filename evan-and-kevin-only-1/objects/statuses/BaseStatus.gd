class_name BaseStatus extends Node

enum elements {none, ice, fire, water, plant, earth, light, plague, ether}

## Name displayed to player.
var display_name: String
## Description of status.
var descr: String
## Determines display color and what creatures are immune to it.
var element_id: int
## If true, it won't go away on creature death.
var is_terrain: bool
## If true, it won't be cleared by terrain clearing moves.
var summon_boost = false
## If true, it will go away on the foe's death. For example, Hailfire.
var tied_to_foe: bool
## If true, gets cleared after moves are used, before summoning next creatures.
var lasts_one_turn: bool

## Damage boost to moves by user. Accumulated, etc.
func extra_damage_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	return 1.0

## Speed boost to moves by user. Charged, etc.
func extra_speed_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	return 1.0

## Damage boost to moves used on user. Melting, etc.
func extra_damage_intake_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	return 1.0

## Accuracy boost to moves by user. Mist, etc.
func extra_accuracy_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	return 1.0

## Accuracy boost to moves used on user. Glowing, etc.
func extra_accuracy_intake_multipliers(_user: BaseCreature, _target: BaseCreature, _move: BaseMove) -> float:
	return 1.0

# Runs when initially applied.
# func on_apply(_user: BaseCreature) -> String:
	# return ""

## Runs when a creature is summoned.
func on_summon(_user: BaseCreature) -> String:
	return ""

## Runs on end of turn.
func end_of_turn(_user: BaseCreature, _target: BaseCreature) -> String:
	return ""

## Runs when user uses a move. Used for Scorching, etc.
func deal_damage(_user: BaseCreature, _target: BaseCreature, _damage: int) -> String:
	return ""
