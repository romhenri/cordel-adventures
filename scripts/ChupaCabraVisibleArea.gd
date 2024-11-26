extends Area2D

@onready var is_first_time : bool = true

@onready var tick_cicle : int = 30

func _physics_process(_delta):
	if tick_cicle == 0:
		tick_cicle = 30
	
	tick_cicle -= 1
	
	if tick_cicle == 2:
		pass

func _on_body_entered(_body):
	if is_first_time:
		get_parent().get_node("player").say_msg("msg_danado")
		is_first_time = false
