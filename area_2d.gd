extends CharacterBody2D

@export var speed = 20
@export var sprite_frame :int
@export var paddle_type = 1
var direction = 1 
func _ready() -> void:
	$Sprite2D.frame =sprite_frame
	
func _process(delta: float) -> void:
	if paddle_type ==1:
		var velocity = Vector2(direction*speed,0)
		var collision = move_and_collide(velocity*delta)

		if collision:
			var collider =collision.get_collider()
			if collider:
				direction *=-1
				
	if paddle_type == 2:
		var velocity = Vector2(direction*speed,0)
		var collision = move_and_collide(velocity*delta)
		if collision:
			var collider =collision.get_collider()
			if collider:
				direction *=-1
		
		
		
		
