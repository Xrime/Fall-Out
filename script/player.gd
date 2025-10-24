extends CharacterBody2D

@export var gravity = 980
@export var speed := 200
@export var jump_force := -200
var start_falling : float
var is_falling = false
var falling_distance : float
var gameover_scene : PackedScene = preload("res://scenes/game_over.tscn")
const acceleration =0.1
const deceleration =0.1
var last_hit =null

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Right"):
		position.x += speed * delta
	if Input.is_action_pressed("Left"):
		position.x -= speed * delta
	if not is_on_floor():
		velocity.y += gravity * delta
	
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
	move_and_slide()
#staticbody coll
	var current_hit = null
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider in Global.fragile_tilemaps:
			current_hit=collider
			if collider!= last_hit:
				var usetime = collider.get_meta("usetime")
				usetime -=1
				collider.set_meta("usetime" , usetime)
				print("collide",collider.name)
				if usetime <= 0:
					collider.queue_free()
					Global.fragile_tilemaps.erase(collider)
					#Global.useime = 3 
	last_hit=current_hit
#staticbody coll end
			
	#var collision = move_and_collide(velocity*delta)
	#if collision:
		#print("acceleration")
		#if collision.get_collider()==Global.fragile_tilemap:
			#Global.useime-=1
			#print("collide" , collision.get_collider()) 
#falling 
	if falling_distance >= 100:
		get_tree().set_meta("level_scene", get_tree().current_scene.scene_file_path)
		get_tree().change_scene_to_packed(gameover_scene)
#turing off difficulties to reduce testing time
