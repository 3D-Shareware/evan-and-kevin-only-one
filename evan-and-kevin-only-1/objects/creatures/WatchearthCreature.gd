class_name WatchearthCreature extends EarthCreature

func ready_creature():
	display_name = "Watchearth"
	sprite_path = load("res://assets/creatures/watchearth.png")
	spawn_anim = "Drill"
	base_health = 100
	base_power = 100
	base_speed = 100
	guaranteed_moves = [TremorMove]
	extra_moves = [BanefulStrikeMove, BrambleBashMove, DownpourMove, ExtinguishMove, FireboltMove, FlashfireMove,
	IcicleMove, LashOutMove, LightRayMove, LightspeedMove, PiercingVenomMove, ShootingStarMove, SubzeroSlashMove,
	TimberMove]
