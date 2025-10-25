extends Node2D
@onready var label = $player/RichTextLabel
@onready var label1 = $player/RichTextLabel2
@export var storyscene :PackedScene

func _ready() -> void:
	Global.space_mode= true
	Global.is_oxygen =true
	var fragile_list =[]
	for child in get_children():
		if child is StaticBody2D:
			child.set_meta("usetime" , 3)
			fragile_list.append(child)
	Global.fragile_tilemaps =fragile_list
	
func _on_exitarea_body_entered(body: Node2D) -> void:
	print("Enter")
	get_tree().change_scene_to_packed(storyscene)
	
func _process(delta: float) -> void:
	label.text="Coin :"+ str(Global.in_game_coin_count)
	label.text ="Oxygen:" + str(int(Global.oxygen))
