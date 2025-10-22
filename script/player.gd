extends CharacterBody2D

@export var gravity = 980
var speed :=200
var jump_force=-200

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Right"):
		position.x += speed*delta
	if Input.is_action_pressed("Left"):
		position.x -= speed*delta
	if not is_on_floor():
		velocity.y+=gravity*delta
	move_and_slide()
	if Input.is_action_pressed("Up") and is_on_floor():
		velocity.y=jump_force
