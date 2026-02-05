class_name CreatureReward extends BaseReward

func set_reward(game_runner: Node, _strength: int):
	reward = game_runner.all_creatures[randi_range(0, game_runner.all_creatures.size() - 1)].new()
	display_name = reward.display_name

func add_reward(game_runner: Node):
	game_runner.teams[0].append(reward)
