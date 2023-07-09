extends CharacterBody2D

@onready var time_to_clear_dialogue: int = 25

@onready var can_move: bool = true
@onready var can_attack: bool = true

@onready var texture: Sprite2D = get_node("Texture")
@onready var collision: CollisionShape2D = get_node("Collision")
@onready var animation: AnimationPlayer = get_node("Animation")
@onready var dialogue: Label = get_node("Dialogue")
@export var move_speed: float = 356.0

func _ready():
	pass

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
	elif (direction.x < 0):
		texture.flip_h = true
	
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
			dialogue.text = "Essa peste dói dimais"
		
		"":
			dialogue.text = ""
	
	time_to_clear_dialogue = 300


func _on_animation_finished(anim_name):
	match anim_name:
		"attack":
			can_attack = true
			can_move = true
		
