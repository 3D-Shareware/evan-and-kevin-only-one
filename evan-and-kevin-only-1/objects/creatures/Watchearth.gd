class_name WatchearthCreature extends EarthCreature

func ready_creature():
	display_name = "Watchearth"
	sprite_path = load("res://assets/creatures/watchearth.png")
	spawn_anim = "Drill"
	descr = "Statue older than anything alive. Its purpose was forgotten ages ago. It has recorded thousands of years of human progress and has knowledge of every technique ever known, human or beast. Its wealth of information would be incredibly useful if it bothered to share it."
	base_health = 100
	base_power = 100
	base_speed = 100
	guaranteed_moves = [TremorMove]
	extra_moves = [AccumulateMove, AnchorSlamMove, ApocalypseMove, ArmorForgeMove, BambooShootMove, BanefulStrikeMove,
	BrambleBashMove, BurningDemonMove, BurningSoulMove, CannabalismMove, ChargeMove, ChickenOutMove, CollisionCourseMove,
	CombustMove, CompostMove, CrashingWaveMove, CrushMove, DeadlyRageMove, DemonsFireMove, DiamondSwordMove,
	DivineInterventionMove, DownpourMove, DozeMove, DrillSpinMove, DrySpellMove, ExtinguishMove, FallingRockMove,
	FireboltMove, FlashfireMove, FreezingPointMove, FunkyTonicMove, HailfireMove, HardenMove, HauntMove, HealingWaterMove,
	HeatBlastMove, HotLavaMove, HydroBurstMove, IcicleMove, InsidesOutMove, JusticeMove, LandslideMove, LashOutMove,
	LastWishMove, LiftoffMove, LightRayMove, LightspeedMove, MercyMove, PassOnMove, PhotosynthesisMove, PiercingVenomMove,
	PlunderMove, PressurizeMove, PurePowerMove, RollMove, SafetyBubbleMove, SavingGraceMove, ShadowTraceMove,
	ShatterMove, ShieldBashMove, ShootingStarMove, SinkMove, SmogMove, SniffOutMove, SnowBombMove, SnowdriftMove,
	StanceChangeMove, StoneThrowMove, StormSpellMove, StrangeFlashMove, SubzeroSlashMove, SuperheatMove,
	ThermalLaserMove, ThornsFirstMove, ThousandYearsMove, TimberMove, TransmutationMove, TwinkleMove]
# 78 extra moves is crazy
