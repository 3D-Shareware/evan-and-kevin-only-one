class_name BaseReward extends Node

## Name displayed.
var display_name: String

## What gets rewarded.
var reward

func set_reward(_game_runner: Node, _strength: int):
	pass

## Adds reward to whatever it needs to be added to.
func add_reward(_game_runner: Node):
	pass
