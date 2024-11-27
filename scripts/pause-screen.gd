extends Control

var a = -1

func _ready():
	hide()
	get_tree().paused = false

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		pause()

func pause():
	a *= -1
			
	if a == 1:
		show()
		get_tree().paused = true
		
	if a == -1:
		hide()
		get_tree().paused = false

func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_menu_pressed() -> void:
	get_tree().paused = false
	hide()
	Player.health = 100
	Transition.scene_path = "res://manegement/menu.tscn"
	Transition.fade_in()

func _on_restart_pressed() -> void:
	Transition.fade_in()
	get_tree().paused = false
	hide()

	var current_scene = get_tree().current_scene
	var packed_scene = preload("res://scenes/map.tscn")
	
	get_tree().change_scene_to_packed(packed_scene)
	Player.health = 100
