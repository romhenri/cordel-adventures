extends CanvasLayer

@onready var animation: AnimationPlayer = get_node("Animation")

var scene_path: String = ""

func fade_in() -> void:
	animation.play("fade_in")

func death() -> void:
	animation.play("death_in")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name ==  "fade_in":
		get_tree().change_scene_to_file(scene_path)
		animation.play("fade_out")
	if anim_name == "death_in":
		get_tree().change_scene_to_file("res://scenes/screens/death-screen.tscn")
		animation.play("death_out")
