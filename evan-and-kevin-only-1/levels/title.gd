extends Node2D

@onready var play_button = $"Play Button"
@onready var dex_button = $"Dex Button"
@onready var fullscreen_button = $"Fullscreen Button"

func _ready():
	play_button.set_element_and_text(-1, "[center]Play [/center]")
	play_button.get_node("Talisman").hide()
	play_button.id = 1
	dex_button.set_element_and_text(-1, "[center]View Creatures [/center]")
	dex_button.get_node("Talisman").hide()
	dex_button.id = 2
	fullscreen_button.set_element_and_text(-1, "[center]Toggle Fullscreen [/center]")
	fullscreen_button.get_node("Talisman").hide()
	fullscreen_button.id = 4
	if get_parent().beat_game:
		$"The Only One".hide()
		$"Gardean".show()

func describe_button(_id: int):
	pass

func button_pressed(id: int):
	if id == 4:
		get_parent().toggle_fullscreen()
	else:
		get_parent().change_scene(id)
