extends Node2D

@onready var label =$Control/RichTextLabel
@export var scene :PackedScene
@export var scene1 :PackedScene
@export var scene2 :PackedScene
@export var scene3 :PackedScene
@export var scene4 :PackedScene

func _ready() -> void:
	label.text = "Coin :"+ str(Global.coins)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(scene)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_packed(scene1)


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_packed(scene2)


func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_packed(scene3)


func _on_button_6_pressed() -> void:
	get_tree().change_scene_to_packed(scene4)
