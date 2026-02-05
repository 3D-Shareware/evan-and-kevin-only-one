class_name KnowledgeReward extends BaseReward

func set_reward(_game_runner: Node, _strength: int):
	display_name = "Learn about The Only One"

func add_reward(game_runner: Node):
	game_runner.known_phases += 1
