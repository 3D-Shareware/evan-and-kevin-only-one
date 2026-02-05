class_name ShinosaurCreature extends LightCreature

func ready_creature():
	display_name = "Shinosaur"
	sprite_path = load("res://assets/creatures/shinosaur.png")
	spawn_anim = "Heavy"
	descr = "Thought to be extinct, but a sudden outbreak proved they were alive and well. Its body shines every color of the rainbow. Staring at its beautiful colors makes it irrationally mad, and those who do so are demolished in a furious rampage."
	base_health = 105
	base_power = 150
	base_speed = 45
	guaranteed_moves = [LightRayMove, PurePowerMove, TwinkleMove, DeadlyRageMove]
	extra_moves = [MercyMove, DrySpellMove, FallingRockMove, SniffOutMove, StrangeFlashMove]
