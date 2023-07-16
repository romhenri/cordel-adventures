extends Sprite2D

@onready var player_ref = null
@onready var tick_cicle : int = 5

@export var damage : bool = 35

func _physics_process(_delta):
	if tick_cicle == 0:
		tick_cicle = 5
	
	tick_cicle -= 1
	
	if player_ref == null:
		return
	
	if tick_cicle == 2:
		player_ref.update_health(damage)

func _on_damage_area_body_entered(body):
	body.move_speed = 26
	player_ref = body

func _on_damage_area_body_exited(body):
	body.move_speed = 306
	player_ref = null
