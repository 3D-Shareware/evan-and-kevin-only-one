extends Node

enum scenes {title, game, dex}

var scene_collection = [preload("res://levels/title.tscn"), preload("res://levels/game_runner.tscn"), preload("res://levels/dex.tscn")]

var current_scene: Node

var fullscreen = false

var beat_game = false

func _ready() -> void:
	change_scene(scenes["title"])

func change_scene(scene_id: int):
	if current_scene != null:
		current_scene.queue_free()
	var new_scene = scene_collection[scene_id].instantiate()
	add_child(new_scene)
	current_scene = new_scene

func toggle_fullscreen():
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = false
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = true
