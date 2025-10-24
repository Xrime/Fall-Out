extends Node2D

@onready var label =$Control/RichTextLabel

func _ready() -> void:
	label.text = "Coin"+ str(Global.coins)
