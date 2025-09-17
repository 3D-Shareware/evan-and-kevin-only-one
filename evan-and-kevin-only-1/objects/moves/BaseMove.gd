class_name BaseMove extends Node

enum elements {none, ice, fire, water, plant, earth, light, plague}

## True for attacks, false for status moves.
var deals_damage: bool

## Multipled by user's Power to obtain the damage this move deals. 150 = x1.5 Power
var damage: int

## Multipled by user's Speed to obtain the Action Speed of the user that turn. Faster creature moves first. 150 = x1.5 Speed
var action_speed: int

## From 0 to 100.
var accuracy: int

## inherit, ice, fire, earth, water, plant, light, plague.
## Setting an element to inherit makes it the same as the user's type.
var element_id: int

## Name of move.
var move_name: String

## Melee, Launch, Stomp, Grow
var move_animation: String

## Describes what move does to the player.
var descr: String

## Returns the damage the move does, excluding type advantage.
func get_damage(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	return user.power * self.damage

## What the move does if it doesn't miss the foe.
func on_hit(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> String:
	return ""
