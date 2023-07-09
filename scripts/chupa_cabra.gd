extends CharacterBody2D

@onready var player_ref = null

@onready var detect_area: CollisionShape2D = get_node("DetectionArea/Detection")
@onready var animation: AnimationPlayer = get_node("Animation")
@onready var texture: Sprite2D = get_node("Texture")

@export var distance_threshold: int = 90
@export var enemy_move_speed: float = 192

var is_attacking: bool = false
var can_die : bool = false

func _ready():
	pass

func _physics_process(_delta):
	
	
	if player_ref == null:
		velocity = Vector2.ZERO
		animate()
		return
	
	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	var distance: float = global_position.distance_to(player_ref.global_position)
	
	if direction.x > 0:
		texture.flip_h = false
	if direction.x < 0:
		texture.flip_h = true

	if is_attacking == true:
		return

	if distance < distance_threshold:
		velocity = Vector2.ZERO
		animation.play('attack')
		return
	
	velocity = direction * enemy_move_speed
	move_and_slide()
	animation.play("run")
	animate()

func animate():
	pass

	
func attack():
	pass

func attack_jump():
	self.position.x += 100
	pass


func _on_detection_area_body_entered(body):
	player_ref = body
	detect_area.debug_color = Color("d1564820")


func _on_animation_started(anim_name):
	match anim_name:
		"attack":
			is_attacking = true


func _on_animation_finished(anim_name):
	match anim_name:
		"attack":
			is_attacking = false


func _on_attack_area_body_entered(body):
	#body.get_node("Texture").flip_v = true
	pass
