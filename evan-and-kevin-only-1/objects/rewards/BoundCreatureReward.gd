class_name BoundCreatureReward extends BaseReward

func set_reward(game_runner: Node, strength: int):
	var talisman = game_runner.all_talismans[randi_range(0, game_runner.all_talismans.size() - 1)].new()
	for i in strength:
		talisman.level = max(talisman.level, randi_range(4, 6))
	reward = game_runner.all_creatures[randi_range(0, game_runner.all_creatures.size() - 1)].new()
	reward.bound_talisman = talisman
	display_name = "Lv. " + str(talisman.level) + " " + str(talisman.display_name) + " " + reward.display_name

func add_reward(game_runner: Node):
	game_runner.teams[0].append(reward)
