class_name BaseTalisman extends Node

## Name prefix.
var display_name: String
## Texture name.
var texture_path: String

## Description to player.
var descr: String

## Level of talisman, each level over 1 increasing summoned creature's stats by 20%
var level: int

## Run when talisman is attached to a creature at start of its summon.
func play_talisman(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array):
	pass
