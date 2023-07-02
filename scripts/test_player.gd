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
	# print(direction)
	velocity = direction * move_speed
	move_and_slide()
	

func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	#Input.get_axis("move_left", "move_right"),
	#Input.get_axis("move_up", "move_down")
	).normalized()

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#	move_and_slide()
