extends Node2D


func _on_button_2_pressed() -> void:
	var start_menu = get_tree().get_meta("scene")
	if start_menu:
		get_tree().change_scene_to_file(start_menu)
