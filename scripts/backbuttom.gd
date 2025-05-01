extends Button


@export var scene_path: String

func _on_pressed():
	get_tree().change_scene_to_file(scene_path)
	pass # Replace with function body.


func _on_mouse_entered():
	modulate.a = 0.5
	pass # Replace with function body.


func _on_mouse_exited():
	modulate.a = 1
	pass # Replace with function body.
