extends CharacterBody2D

@onready var is_first_time : bool = true

@onready var time_to_clear_dialogue: int = 2

@onready var dialogue: Label = get_node("Dialogue")

func _physics_process(_delta: float) -> void:
	if (time_to_clear_dialogue > 0):
		time_to_clear_dialogue -= 1
	if (time_to_clear_dialogue == 1):
		dialogue.text = ""
		
		if is_first_time:
			say("msg_praga")
			is_first_time = false
	

# TALK SYSTEM
func say(msg):
	match msg:
		"msg_salve":
			dialogue.text = "Você precisa salvar sua terra."
		
		"msg_praga":
			dialogue.text = "A praga está chegando e consumirá tudo se não for parada."
		
		"msg_homemboi":
			dialogue.text = "Aquilo é um homem boi?"
		
		"msg_perigo":
			dialogue.text = "Isso é muito perigoso"
		
		"":
			dialogue.text = ""
	
	time_to_clear_dialogue = 700
