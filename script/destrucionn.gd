extends Node2D

@export var rotation_speed : = 3.0
@onready var label = $player/RichTextLabel
@export var storyscene :PackedScene

func _ready() -> void:
	Global.destruction=true
	Global.win = false
	var fragile_list =[]
	for child in get_children():
		if child is StaticBody2D:
			child.set_meta("usetime" , 3)
			fragile_list.append(child)
	Global.fragile_tilemaps =fragile_list

func _process(delta: float) -> void:
	rotation_degrees += rotation_speed*delta
	label.text ="Oxygen:" + str(int(Global.oxygen))
