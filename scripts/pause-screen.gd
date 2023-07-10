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
