class_name BerserkTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Berserk"
	texture_path = "berserk"
	descr = "This creature is limited to 2 random moves every turn, but all stats are increased by 30%."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	user.apply_status(BerserkStatus.new(), battle_properties)
	@warning_ignore("narrowing_conversion")
	user.max_health *= 1.3
	@warning_ignore("narrowing_conversion")
	user.health *= 1.3
	@warning_ignore("narrowing_conversion")
	user.power *= 1.3
	@warning_ignore("narrowing_conversion")
	user.speed *= 1.3
