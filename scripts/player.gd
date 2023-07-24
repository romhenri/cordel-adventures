extends CharacterBody2D

@onready var time_to_clear_dialogue: int = 25
@onready var player_damage: int = 25

@onready var can_move: bool = true
@onready var can_attack: bool = true
@onready var is_alive: bool = true

@onready var texture: Sprite2D = get_node("Texture")
@onready var attack_trail: Sprite2D = get_node("Texture/AttackTrail")
@onready var collision: CollisionShape2D = get_node("Collision")
@onready var animation: AnimationPlayer = get_node("Animation")
@onready var aux_animation: AnimationPlayer = get_node("AuxAnimation")
@onready var dialogue: Label = get_node("Dialogue")
@onready var attack_area_collision : CollisionPolygon2D = get_node("AttackArea/Attack")
@export var move_speed: float = 356.0

func _ready():
	attack_area_collision.rotation = 135
	say("msg_pesadelo")
	
func _physics_process(_delta: float) -> void:
	
	if (time_to_clear_dialogue > 0):
		time_to_clear_dialogue -= 1
	if (time_to_clear_dialogue == 1):
		dialogue.text = ""
	
	if can_move && can_attack:
		move()
	
	attack_handler()

func attack_handler() -> void:
	
	if Input.is_action_just_pressed("attack"):
		can_attack = false
		can_move = false
		animation.play("attack")

# MOVE SYSTEM
func move() -> void:
	var direction: Vector2 = get_direction()
	
	if (direction.x == 0 and direction.y): 
		pass
	elif (direction.x > 0): 
		texture.flip_h = false
		attack_trail.flip_h = false
		attack_area_collision.rotation = 135
		
	elif (direction.x < 0):
		texture.flip_h = true
		attack_trail.flip_h = true
		attack_area_collision.rotation = 0
	
	if (direction.x != 0 || direction.y != 0): 
		animation.play("run")
	else:
		animation.play("idle")
	
	velocity = direction * move_speed
	move_and_slide()

func get_direction() -> Vector2:
	return Vector2(
	Input.get_axis("move_left", "move_right"),
	Input.get_axis("move_up", "move_down")
	).normalized()

# TALK SYSTEM
func say(msg):
	match msg:
		"msg_loucura":
			dialogue.text = "Que loucura."
		
		"msg_homemboi":
			dialogue.text = "Aquilo é um homem boi?"
		
		"msg_perigo":
			dialogue.text = "Isso é muito perigoso"
		
		"msg_doi":
			dialogue.text = "Essa peste dói demais"
		
		"msg_pesadelo":
			dialogue.text = "Pesadelo toda hora"
		
		"msg_danado":
			dialogue.text = "Que danado é isso?"
		
		"":
			dialogue.text = ""
	
	time_to_clear_dialogue = 300


func _on_animation_finished(anim_name):
	match anim_name:
		"attack":
			can_attack = true
			can_move = true

func update_health(value: int) -> void:
	aux_animation.play("hit")
	Player.health -= value
	get_parent().get_node("ui-gameplay").update()
	
	if Player.health <= 0:
		queue_free()
		
		Transition.death()

func _on_attack_area_body_entered(body):
	body.update_health(player_damage)
