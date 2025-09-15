extends Sprite2D

func shake_screen():
	if get_parent():
		get_parent().get_parent().play_camera_anim("screenshake")

func earthquake_screen():
	if get_parent():
		get_parent().get_parent().play_camera_anim("earthquake")
