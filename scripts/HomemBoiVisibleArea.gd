extends Area2D

@export var tick : int = 1

@onready var player : CharacterBody2D = get_parent().get_node("player")
@onready var homemboi : CharacterBody2D = get_parent().get_node("homemboi")

func _physics_process(_delta):
	if tick == 0:
		tick = 1
	
	tick -= 1
	
	if tick == 2:
		homemboi.say("msg_salve")
		queue_free()

func _on_body_entered(body):
	print(body)
	player.say("msg_homemboi")
	
	tick = 200
