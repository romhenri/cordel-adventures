extends Sprite2D

@onready var is_first_time : bool = true

func _on_collision_body_entered(body):
	body.move_speed = 36

func _on_collision_body_exited(body):
	body.move_speed = 306
