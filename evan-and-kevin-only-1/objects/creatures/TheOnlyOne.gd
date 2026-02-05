class_name TheOnlyOne extends BaseCreature

var final_phase_moves = []

func _init() -> void:
	pass # doesn't crash the game

func _ready() -> void:
	super._init()

func ready_element():
	if element_id == elements["ice"]:
		sprite_path = load("res://assets/the_only_one/ice.png")
		weaknesses = [elements["fire"], elements["light"], elements["ether"]]
		guaranteed_moves = [AccumulateMove, FreezingPointMove, HailfireMove, IcicleMove, SlushMove, SmogMove, SnowBombMove,
		SnowdriftMove, StormSpellMove, SubzeroSlashMove]
		for i in guaranteed_moves:
			final_phase_moves.append(i)
	elif element_id == elements["fire"]:
		sprite_path = load("res://assets/the_only_one/fire.png")
		weaknesses = [elements["water"], elements["earth"], elements["ether"]]
		guaranteed_moves = [ArmorForgeMove, BurningSoulMove, DemonsFireMove, FireboltMove, FlashfireMove,
		HeatBlastMove, HotLavaMove, StanceChangeMove, SuperheatMove, ThermalLaserMove]
		for i in guaranteed_moves:
			final_phase_moves.append(i)
	elif element_id == elements["water"]:
		sprite_path = load("res://assets/the_only_one/water.png")
		weaknesses = [elements["ice"], elements["plant"], elements["light"], elements["plague"], elements["ether"]]
		guaranteed_moves = [AccumulateMove, AnchorSlamMove, CrashingWaveMove, DownpourMove, DozeMove, ExtinguishMove,
		HealingWaterMove, InsidesOutMove, SafetyBubbleMove, StormSpellMove]
		for i in guaranteed_moves:
			final_phase_moves.append(i)
	elif element_id == elements["earth"]:
		sprite_path = load("res://assets/the_only_one/earth.png")
		weaknesses = [elements["plant"], elements["water"], elements["ether"]]
		guaranteed_moves = [CollisionCourseMove, CrushMove, DiamondSwordMove, DrillSpinMove, DrySpellMove, FallingRockMove,
		HardenMove, LandslideMove, LiftoffMove, RollMove, StoneThrowMove, TremorMove]
		for i in guaranteed_moves:
			final_phase_moves.append(i)
	elif element_id == elements["plant"]:
		sprite_path = load("res://assets/the_only_one/plant.png")
		weaknesses = [elements["fire"], elements["ice"], elements["plague"], elements["ether"]]
		guaranteed_moves = [BambooShootMove, BrambleBashMove, ChargeMove, PhotosynthesisMove, ThornsFirstMove,
		ThousandYearsMove, TimberMove, LightRayMove]
		for i in guaranteed_moves:
			final_phase_moves.append(i)
	elif element_id == elements["light"]:
		sprite_path = load("res://assets/the_only_one/light.png")
		weaknesses = [elements["plant"], elements["earth"], elements["plague"], elements["ether"]]
		guaranteed_moves = [DivineInterventionMove, DrySpellMove, JusticeMove, LightRayMove, LightspeedMove, MercyMove,
		PurePowerMove, SavingGraceMove, ShootingStarMove, StrangeFlashMove]
		for i in guaranteed_moves:
			final_phase_moves.append(i)
	elif element_id == elements["plague"]:
		sprite_path = load("res://assets/the_only_one/plague.png")
		weaknesses = [elements["fire"], elements["light"], elements["ether"]]
		guaranteed_moves = [BanefulStrikeMove, BurningDemonMove, CannabalismMove, DemonsFireMove, FunkyTonicMove,
		LashOutMove, PiercingVenomMove, ShadowTraceMove, SmogMove]
		for i in guaranteed_moves:
			final_phase_moves.append(i)
	elif element_id == elements["none"]:
		sprite_path = load("res://assets/the_only_one/final.png")
		weaknesses = [elements["ether"]]
		guaranteed_moves = final_phase_moves
	if get_parent().has_method("clear_immune_ailments"):
		get_parent().clear_immune_ailments(self)

func ready_creature():
	boss = true
	if get_parent().has_method("activate_moves"):
		element_id = get_parent().boss_phases[0]
		get_parent().boss_phases.pop_at(0)
		if !level:
			if get_parent().difficulty == 1:
				level = 5
			elif get_parent().difficulty == 2:
				level = 7
			else:
				level = 9
		else:
			animate_move("GrowBoss")
			ready_element()
			sprite.texture = sprite_path
	else: # if false, you're in the dex
		element_id = 0
		level = 7
	display_name = "The Only One"
	spawn_anim = "DrillBoss"
	descr = "A being that forgoes the natural cycle of life. It draws power from the lifeforce of every other creature. The chaos caused by its incredible power has caused countless disasters and thrown the ecosystem into disarray. One swipe of its claw can split a mountain in two. Life cannot continue while this creature refuses to die."
	base_health = 250
	base_power = 100
	base_speed = 100
	armor = 0
	max_armor = 0

func revive():
	level += 1
	get_parent().pop_non_terrains_on_revive()
	ready_creature()
	ready_rest_of_creature()
