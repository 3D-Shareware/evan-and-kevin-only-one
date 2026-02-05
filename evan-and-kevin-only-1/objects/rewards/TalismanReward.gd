class_name TalismanReward extends BaseReward

func set_reward(game_runner: Node, strength: int):
	reward = game_runner.all_talismans[randi_range(0, game_runner.all_talismans.size() - 1)].new()
	var rng = 0
	for i in strength:
		var new_rng = randf()
		rng = max(new_rng, rng)
	if strength < 3:
		rng = min(rng, 0.9)
	elif strength >= 5:
		rng = max(rng, 0.8)
	if rng > 0.995:
		reward.level = 6
	elif rng > 0.98:
		reward.level = 5
	elif rng > 0.95:
		reward.level = 4
	elif rng > 0.75:
		reward.level = 3
	elif rng > 0.5:
		reward.level = 2
	else:
		reward.level = 1
	display_name = "Lv. " + str(reward.level) + " " + reward.display_name + " Talisman"

func add_reward(game_runner: Node):
	game_runner.talismans.append(reward)
