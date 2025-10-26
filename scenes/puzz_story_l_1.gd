extends Node2D
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
	Global.win = true
	Global.mode = "puzzle"
	Global.level = 1
	print("Enter")
	get_tree().set_meta("scene2",get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_packed(storyscene)
func _process(delta: float) -> void:
	label.text="Coin :"+ str(Global.in_game_coin_count)
