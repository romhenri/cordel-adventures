extends Sprite2D

@onready var is_first_time : bool = true

func _on_damage_area_body_entered(body):
	body.move_speed = 106
	
	if is_first_time:
		get_parent().get_parent().get_parent().get_node("player").say("msg_doi")
		is_first_time = false

func _on_damage_area_body_exited(body):
	body.move_speed = 356
