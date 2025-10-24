extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name=="player":
		Global.add_power_ups("slow_motion" ,1)
		queue_free()
	print(Global.power_ups)
			
