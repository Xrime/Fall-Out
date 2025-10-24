extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.add_coin(1)
		queue_free()
		print(Global.coins)
