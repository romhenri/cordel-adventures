extends Control

func _ready():
	for button in get_tree().get_nodes_in_group("buttons"):
		button.pressed.connect(on_button_pressed.bind(button.name))

func on_button_pressed(button_name: String) -> void:
	match button_name:
		"menu":
			Player.health = 100
			Transition.scene_path = "res://manegement/menu.tscn"
			Transition.fade_in()
	
		"quit":
			get_tree().quit()
