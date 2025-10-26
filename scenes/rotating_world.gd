extends Node2D

@export var scene1 :PackedScene 
@export var scene2 : PackedScene
@onready var label =$Control/RichTextLabel
@onready var label1 = $Control/RichTextLabel2
@onready var label2 =$Control/RichTextLabel3
@onready var label4 =$Control/RichTextLabel4

func _ready() -> void:
	label.text = "Coin :"+ str(Global.coins)
	label1.text ="Slow motion"+str(Global.slow_motion)
	label2.text = "Shield" + str(Global.sheild)
	label4.text = "Double Jump" + str(Global.double_jump)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(scene1)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_packed(scene2)
	
func _on_button_3_pressed() -> void:
	var main_menu = get_tree().get_meta("scene1")
	if main_menu:
		get_tree().change_scene_to_file(main_menu)
