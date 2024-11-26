extends Area2D

@export var tick : int = 1
@export var msg : String = ""

@onready var player : CharacterBody2D = get_parent().get_parent().get_node("player")

func _physics_process(_delta):
	if tick == 0:
		tick = 1
	
	tick -= 1

func _on_body_entered(body):
	player.area_msg = msg
	
	tick = 200

func _on_body_exited(body: Node2D) -> void:
	player.area_msg = ""
