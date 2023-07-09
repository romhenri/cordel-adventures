extends CanvasLayer

func _ready():
	for button in get_tree().get_nodes_in_group("buttons"):
		button.pressed.connect(on_button_pressed.bind(button.name))

func on_button_pressed(button_name: String) -> void:
	match button_name:
		"esc":
			print("Start")
