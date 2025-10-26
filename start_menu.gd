extends Node2D

@export var scene :PackedScene
@export var  scene1 : PackedScene

func _on_button_pressed() -> void:
	get_tree().set_meta("scene1", get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_packed(scene)

func _on_button_2_pressed() -> void:
	get_tree().set_meta("scene1", get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_packed(scene1)
