extends Sprite2D

@onready var player_ref = null
@onready var tick_cicle : int = 5

@export var damage : int = 3

func _physics_process(_delta):
	if tick_cicle == 0:
		tick_cicle = 5
	
	tick_cicle -= 1
	
	if player_ref == null:
		return
	
	if tick_cicle == 2:
		player_ref.update_health(damage)

func _on_damage_area_body_entered(body):
	body.speed = (Player.speed / 9) 
	player_ref = body

func _on_damage_area_body_exited(body):
	body.speed = Player.speed
	player_ref = null
