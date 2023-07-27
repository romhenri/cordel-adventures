extends CharacterBody2D

# Stats
@export var damage: int = Player.damage
@export var speed: int = Player.speed

# Inventory
@export var item: String = "default"
@export var with_hat: bool = false
@onready var sprites = [
	null,
	preload("res://assets/characters/antonio/antonio-sprites-0.png"),
	preload("res://assets/characters/antonio/antonio-sprites-1.png"),
	preload("res://assets/characters/antonio/antonio-sprites-2.png"),
	preload("res://assets/characters/antonio/antonio-sprites-3.png"),
	preload("res://assets/characters/antonio/antonio-sprites-4.png"),
	preload("res://assets/characters/antonio/antonio-sprites-5.png"),
]

# Conditions
@onready var can_move: bool = true
@onready var can_attack: bool = true
@onready var is_alive: bool = true

# Objects
@onready var texture: Sprite2D = get_node("Texture")
@onready var attack_trail: Sprite2D = get_node("Texture/AttackTrail")
@onready var collision: CollisionShape2D = get_node("Collision")
@onready var animation: AnimationPlayer = get_node("Animation")
@onready var aux_animation: AnimationPlayer = get_node("AuxAnimation")
@onready var dialogue: Label = get_node("Dialogue")
@onready var attack_area_collision : CollisionPolygon2D = get_node("AttackArea/Attack")

@onready var time_to_clear_dialogue: int = 25

func _ready():
	attack_area_collision.rotation = 135
	say("msg_pesadelo")

func _physics_process(_delta: float) -> void:
	
	if (time_to_clear_dialogue > 0):
		time_to_clear_dialogue -= 1
	if (time_to_clear_dialogue == 1):
		dialogue.text = ""
	
	if can_move:
		move()
	
	if can_attack:
		attack_handler()

	item_handler()
#_______________________________________________

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
	
	velocity = direction * speed
	move_and_slide()

func get_direction() -> Vector2:
	return Vector2(
	Input.get_axis("move_left", "move_right"),
	Input.get_axis("move_up", "move_down")
	).normalized()
#_______________________________________________

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

#_______________________________________________
# COMBAT SYSTEM
func _on_animation_finished(anim_name):
	match anim_name:
		"attack":
			can_attack = true
			can_move = true

func attack_handler() -> void:
	
	if Input.is_action_just_pressed("attack"):
		can_attack = false
		can_move = false
		animation.play("attack")

func update_health(value: int) -> void:
	aux_animation.play("hit")
	Player.health -= value
	get_parent().get_node("ui-gameplay").update()
	
	if Player.health <= 0:
		queue_free()
		
		Transition.death()

func _on_attack_area_body_entered(body):
	
	body.update_health(damage)
#_______________________________________________

# ITEM SYSTEM
func item_handler():
	if Input.is_action_just_pressed("set1"):
		change_item("default")
		
	if Input.is_action_just_pressed("set2"):
		change_item("attack")
		
	if Input.is_action_just_pressed("set3"):
		change_item("lamp")
		
	if Input.is_action_just_pressed("hat"):
		if with_hat:
			with_hat = false
		else:
			with_hat = true
		change_item(item)

func change_item(set):
	match set:
		"default":
			item = "default"
			can_attack = false
			
			if with_hat:
				texture.texture = sprites[3]
			else:
				texture.texture = sprites[1]
			
		"attack":
			item = "attack"
			can_attack = true
			
			if with_hat:
				texture.texture = sprites[4]
			else:
				texture.texture = sprites[2]
			
		"lamp":
			item = "lamp"
			can_attack = false
			
			if with_hat:
				texture.texture = sprites[6]
			else:
				texture.texture = sprites[5]











