extends CharacterBody2D

@export var gravity = 980
var speed := 200
var jump_force := -200
var start_falling : float
var is_falling = false
var falling_distance : float
var gameover_scene : PackedScene = preload("res://scenes/game_over.tscn")
const acceleration =0.1
const deceleration =0.1


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Right"):
		position.x += speed * delta
	if Input.is_action_pressed("Left"):
		position.x -= speed * delta
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	if Input.is_action_pressed("Up") and is_on_floor():
		velocity.y = jump_force

	if not is_on_floor():
		if not is_falling:
			start_falling = position.y
			is_falling = true
	else:
		if is_falling:
			falling_distance = position.y - start_falling
			print(falling_distance)
			is_falling = false

	if falling_distance >= 100:
		get_tree().set_meta("level_scene", get_tree().current_scene.scene_file_path)
		get_tree().change_scene_to_packed(gameover_scene)
