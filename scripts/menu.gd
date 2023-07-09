extends Control

func _ready():
	for button in get_tree().get_nodes_in_group("buttons"):
		button.pressed.connect(on_button_pressed.bind(button.name))

func on_button_pressed(button_name: String) -> void:
	match button_name:
		"start":
			print("Start")
			
			Transition.scene_path = "res://scenes/map.tscn"
			Transition.fade_in()
	
		"quit":
			get_tree().quit()
