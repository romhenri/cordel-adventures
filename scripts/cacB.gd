extends Sprite2D

func _on_damage_area_body_entered(body):
	body.move_speed = 36

func _on_damage_area_body_exited(body):
	body.move_speed = 356
