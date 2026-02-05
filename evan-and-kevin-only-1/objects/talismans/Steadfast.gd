class_name SteadfastTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Steadfast"
	texture_path = "steadfast"
	descr = "This creature cannot flinch."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	user.apply_status(SteadfastStatus.new(), battle_properties)
