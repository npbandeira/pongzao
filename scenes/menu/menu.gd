extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed",_on_button_pressed.bind(button))
		button.connect("mouse_entered",_mouse_interections.bind(button, "entered"))
		button.connect("mouse_exited", _mouse_interections.bind(button, "exited"))
		#button.connect("mouse_exited",)
	pass # Replace with function body.


func _on_button_pressed(button: Button) -> void:
	match button.name:
		"Jogar":
			get_tree().change_scene_to_file("res://scenes/main/main.tscn")
			pass
		"Controles":
			get_tree().change_scene_to_file("res://scenes/menu/controles.tscn")
			pass
		"Sair":
			get_tree().quit()
			pass
	pass

func _mouse_interections(button: Button, state: String)-> void:
	match state:
		"exited":
			button.modulate.a = 1.0
		"entered":
			button.modulate.a = 0.5
