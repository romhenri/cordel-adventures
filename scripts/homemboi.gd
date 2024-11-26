extends CharacterBody2D

@onready var time_to_clear_dialogue: int = 1

@onready var last_msg = null

@onready var dialogue: Label = get_node("Dialogue")

func _physics_process(_delta: float) -> void:
	if (time_to_clear_dialogue > 0):
		time_to_clear_dialogue -= 1
		
	if (time_to_clear_dialogue == 1):
		if check_next():
			return
		
		dialogue.text = ""

# TALK SYSTEM
func say_msg(msg):
	last_msg = msg
	
	match msg:
		"msg_salve":
			dialogue.text = "Você precisa salvar sua terra"
		
		"msg_praga":
			dialogue.text = "A praga está chegando e consumirá tudo se não for parada"
		
		"msg_perigo":
			dialogue.text = "Isso é muito perigoso"
		
		"":
			dialogue.text = ""
	
	time_to_clear_dialogue = 600
	
func check_next():
	if last_msg == null:
		return
	
	time_to_clear_dialogue = 400
	
	match last_msg:
		"msg_salve":
			dialogue.text = "Você é o único capaz"
			last_msg = null
			return true
		
		_:
			return false
