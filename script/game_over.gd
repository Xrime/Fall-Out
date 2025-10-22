extends Node2D

#@export var level_scene: PackedScene

func _on_button_pressed() -> void:
	var level_path = get_tree().get_meta("level_scene")
	if level_path:
		get_tree().change_scene_to_file(level_path)
	else:
		print("No previous scene path found!")
