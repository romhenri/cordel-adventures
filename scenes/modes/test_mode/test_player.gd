extends CharacterBody2D

@onready var texture: Sprite2D = get_node("Texture")
@onready var collision: CollisionShape2D = get_node("Collision")

@export var move_speed: float = 256.0

func _ready():
	print(texture)
	print(collision)

func _physics_process(_delta: float) -> void:
	move()

func move() -> void:
	var direction: Vector2 = get_direction()
	
	print(direction)
	
	if (direction.x == 0 and direction.y): 
		pass
	elif (direction.x > 0): 
		texture.flip_h = true
	elif (direction.x < 0):
		texture.flip_h = false
	
	velocity = direction * move_speed
	move_and_slide()

func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()
