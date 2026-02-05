class_name ShrikadeeCreature extends PlantCreature

func ready_creature():
	display_name = "Shrikadee"
	sprite_path = load("res://assets/creatures/shrikadee.png")
	spawn_anim = "Rise"
	descr = "Weird bird that balances atop a thorny plant. Hunts and eats anything it can stab with its spikes, which is pretty much everything. Birders are advised against looking for this particular bird, but they won’t listen."
	base_health = 45
	base_power = 115
	base_speed = 140
	guaranteed_moves = [BrambleBashMove, LightspeedMove, ThornsFirstMove, PhotosynthesisMove]
	extra_moves = [TimberMove, CompostMove, ChickenOutMove, LiftoffMove, BanefulStrikeMove]
