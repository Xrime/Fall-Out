extends Node2D
@onready var label = $"Control/coin label"
func _ready() -> void:
	label.text = "coins" +str(Global.coins)
	
func _process(delta: float) -> void:
	label.text = "coins" + str(Global.coins)
	

func _on_item_buttinn_pressed() -> void:
	Global.add_power_ups("slow_motion",1)
	Global.coins-=2


func _on_item_button_2_pressed() -> void:
	Global.add_power_ups("shield" ,1)
	Global.coins -= 10
	


func _on_item_button_3_pressed() -> void:
	Global.add_power_ups("double_jump",1)
	Global.coins -=5
	


func _on_cancel_button_pressed() -> void:
	var scene1 = get_tree().get_meta("scene1")
	if  scene1:
		get_tree().change_scene_to_file(scene1)
