extends TextureButton

@export var page_button = false
@export var advance_text_button = false

@onready var sprite = $"Element"
@onready var talisman = $"Talisman"
@onready var label = $"RichTextLabel"

var talisman_colors = [
	Color.from_hsv(0.08, 0.8, 1.0), # bronze for lv. 1
	Color.from_hsv(0.5, 0.2, 1.0), # silver for lv. 2
	Color.from_hsv(0.16, 1.0, 1.0), # gold for lv. 3
	Color.from_hsv(0.7, 0.5, 1.0), # purple for lv. 4
	Color.from_hsv(0.85, 0.65, 1.0), # pink for lv. 5
	Color.from_hsv(0.0, 0.9, 1.0) # red for overleveled
]

var id = 0

func _ready():
	if page_button:
		sprite.hide()
		talisman.hide()
		label.text = "[center]Next page [/center]"
	elif advance_text_button:
		sprite.hide()
		talisman.hide()
		label.text = "[center]OK [/center]"

func set_element_and_text(element_id: int, txt: String):
	if element_id == -1:
		sprite.hide()
	else:
		sprite.frame = element_id
		sprite.show()
		talisman.hide()
	label.text = txt

func set_talisman_texture(texture: String, level: int):
	talisman.texture = load("res://assets/talismans/" + texture + ".png")
	if texture == "none":
		talisman.modulate = Color.from_hsv(0.4, 0.1, 0.5)
	else:
		talisman.modulate = talisman_colors[min(level - 1, 5)]
	talisman.show()

func _on_mouse_entered() -> void:
	if !page_button and !advance_text_button:
		get_parent().describe_button(id)

func _on_pressed() -> void:
	if page_button:
		get_parent().next_page()
	elif advance_text_button:
		get_parent().emit_signal("advanceText")
	else:
		get_parent().button_pressed(id)
