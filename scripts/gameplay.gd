extends CanvasLayer

@onready var life_points : Label = get_node("LifeCount")

func _ready():
	for button in get_tree().get_nodes_in_group("buttons"):
		button.pressed.connect(on_button_pressed.bind(button.name))
		
	life_points.text = str(Player.health)

func on_button_pressed(button_name: String) -> void:
	match button_name:
		"esc":
			get_parent().get_node("Pause").get_node("pause-screen").pause()

func update():
	life_points.text = str(Player.health)

