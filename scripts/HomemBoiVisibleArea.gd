extends Area2D

@onready var time_to_clear_dialogue: int = 25

@onready var player : CharacterBody2D = get_parent().get_node("player")
@onready var homemboi : CharacterBody2D = get_parent().get_node("homemboi")

func _on_body_entered(body):
	print(body)
	player.say("msg_homemboi")
	homemboi.say("msg_salve")
	queue_free()

