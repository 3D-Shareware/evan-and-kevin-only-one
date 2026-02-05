class_name TimboarCreature extends PlantCreature

func ready_creature():
	display_name = "Timboar"
	sprite_path = load("res://assets/creatures/timboar.png")
	spawn_anim = "Dash"
	descr = "Huge woodland beast. Its incredible nose lets it find and eat rare forest mushrooms. When it pats the ground with its hooves, even the strongest of warriors give it a wide berth, for its charge can punch holes in castle walls."
	base_health = 125
	base_power = 90
	base_speed = 85
	guaranteed_moves = [TimberMove, BrambleBashMove, ChargeMove, SniffOutMove]
	extra_moves = [TremorMove, PhotosynthesisMove, CombustMove, CompostMove, FlashfireMove]
