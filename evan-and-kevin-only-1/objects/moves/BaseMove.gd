class_name BaseMove extends Node

enum elements {none, ice, fire, water, plant, earth, light, plague, ether}

## True for attacks, false for status moves.
var deals_damage: bool

## True for self-destruct moves.
var kills_user: bool

## Multipled by user's Power to obtain the damage this move deals. 150 = x1.5 Power
var damage: int

## Multipled by user's Speed to obtain the Action Speed of the user that turn. Faster creature moves first. 150 = x1.5 Speed
var action_speed: int

## From 0 to 100.
var accuracy: int

## Set to true for parry moves sometimes.
var failing = false

## none, ice, fire, earth, water, plant, light, plague.
var element_id: int

## Name of move.
var move_name: String

## Melee, Launch, Stomp, Grow, Squash
var move_animation: String

## Describes what move does to the player.
var descr: String

## Returns the damage the move does, excluding type advantage.
func get_damage(user: BaseCreature, target: BaseCreature, battle_properties: Array) -> int:
	var damage_multipliers = 1
	for i in battle_properties[user.team]:
		damage_multipliers *= i.extra_damage_multipliers(user, target, self)
	for i in battle_properties[target.team]:
		damage_multipliers *= i.extra_damage_intake_multipliers(user, target, self)
	return damage_multipliers * get_move_specific_damage(user, target, battle_properties)

func get_move_specific_damage(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> float:
	return user.power * self.damage

## What the move does if it doesn't miss the foe.
func on_hit(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	return ""

## What the parry moves do when they fail.
func on_fail(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	return "[color=#ff1717]But it missed![/color]"

## What the move does if it flinches the foe.
func flinch_effects(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> String:
	return ""

## Returns true if this move ALWAYS goes first, like Shadow Trace, and false otherwise.
func always_goes_first(_user: BaseCreature, _target: BaseCreature, _moves: Array) -> bool:
	return false

## Returns priority modifiers for special moves like Slush that need smart AI to use.
func ai_priority(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	return 0
