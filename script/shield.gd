extends Area2D

@export var points :int
@export var respawn_points : Array[Vector2]=[]

func _ready() -> void:
	connect("body_entered" ,Callable(self,"on_body_entered"))
	randomize()
	move_to_random_point()
	
func _on_body_entered(body: Node2D) -> void:
	if body.name=="player":
		Global.using_shield = true
		Global.add_power_ups("shield" ,1)
		queue_free()
	print(Global.power_ups)			

func  move_to_random_point():
	if respawn_points.size() >0:
		var new_pos = respawn_points[randi() % respawn_points.size()]
		global_position = new_pos
