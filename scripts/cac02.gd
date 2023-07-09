extends Sprite2D

@onready var is_first_time : bool = true

@onready var player_ref = null
@onready var tick_cicle : int = 30

@export var damage : bool = 3

func _physics_process(delta):
	print(tick_cicle)
	
	
	if tick_cicle == 0:
		tick_cicle = 30
	
	tick_cicle -= 1
	
	if player_ref == null:
		return
	
	if tick_cicle == 2:
		player_ref.update_health(damage)

func _on_damage_area_body_entered(body):
	body.move_speed = 106
	
	if is_first_time:
		get_parent().get_parent().get_parent().get_node("player").say("msg_doi")
		is_first_time = false
	
	player_ref = body

func _on_damage_area_body_exited(body):
	body.move_speed = 356
	player_ref = null
