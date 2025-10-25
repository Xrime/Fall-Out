extends Node2D

@export var scene1 :PackedScene 
@export var scene2 : PackedScene



func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(scene1)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_packed(scene2)
