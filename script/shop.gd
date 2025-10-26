extends Node2D
@onready var label = $"Control/coin label"
func _ready() -> void:
	label.text = "coins" +str(Global.coins)
	
func _process(delta: float) -> void:
	label.text = "coins" + str(Global.coins)
	

func _on_item_buttinn_pressed() -> void:
	if Global.coins>=2:
		Global.add_power_ups("slow_motion",1)
		Global.coins-=2
		Global.save_coins()

func _on_item_button_2_pressed() -> void:
	if Global.coins >= 10:
		Global.add_power_ups("shield" ,1)
		Global.coins -= 10
		Global.save_coins()


func _on_item_button_3_pressed() -> void:
	if Global.coins >= 5:
		Global.add_power_ups("double_jump",1)
		Global.coins -=5
		Global.save_coins()

func _on_cancel_button_pressed() -> void:
	var scene1 = get_tree().get_meta("scene")
	if  scene1:
		get_tree().change_scene_to_file(scene1)
