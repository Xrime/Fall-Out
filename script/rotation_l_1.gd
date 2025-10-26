extends Node2D


@export var rotation_speed : = 2.0
@onready var label = $player/RichTextLabel
@export var storyscene :PackedScene

func _ready() -> void:
	Global.win = false
	var fragile_list =[]
	for child in get_children():
		if child is StaticBody2D:
			child.set_meta("usetime" , 3)
			fragile_list.append(child)
	Global.fragile_tilemaps =fragile_list
func _on_exitarea_body_entered(body: Node2D) -> void:
	Global.win =true
	Global.mode ="spinning"
	Global.level = 1
	print("Enter")
	get_tree().set_meta("scene4",get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_packed(storyscene)
func _process(delta: float) -> void:
	rotation_degrees += rotation_speed*delta
	label.text="Coin :"+ str(Global.in_game_coin_count)
