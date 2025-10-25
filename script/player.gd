extends CharacterBody2D

var gravity = Global.gravity
var speed := Global.speed
var jump_force := Global.jump_force

var start_falling : float
var is_falling = false
var falling_distance : float
var gameover_scene : PackedScene = preload("res://scenes/game_over.tscn")

const acceleration =0.1
const deceleration =0.1

var last_hit =null
var use_time =0
var is_using=false

var jump_count :=0.0
var max_jump :=0.0


func _physics_process(delta: float) -> void:
	gravity = Global.gravity
	speed = Global.speed
	jump_force = Global.jump_force
	if Input.is_action_pressed("Right"):
		position.x += speed * delta
	if Input.is_action_pressed("Left"):
		position.x -= speed * delta
	if not is_on_floor():
		velocity.y += gravity * delta
	else :
		jump_count=0.0
	
	if Global.using_double_jump:
		max_jump=2
		is_using = true
	else :
		max_jump = 1
	if Input.is_action_just_pressed("Up") and jump_count< max_jump:
		velocity.y =jump_force
		jump_count +=1
	if is_using:
		use_time += delta
		if use_time >= 5.0:
			is_using = false
			Global.using_double_jump =false
			Global.using_slow_power_up = false
			Global.using_shield = false
			use_time = 0.0
			print("power up expire")
			
	if Global.using_slow_power_up: 
		is_using=true
		gravity=500
		print("Using power up")
		if is_using:
			use_time+=delta	
			if use_time >= 5.0:
				is_using=false
				Global.using_slow_power_up=false
				use_time=0.0
				gravity=980
				print("Power up off")
		
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
					
	last_hit=current_hit
	
	if Global.using_shield:
		if falling_distance >= 1000:
			get_tree().set_meta("level_scene", get_tree().current_scene.scene_file_path)
			get_tree().change_scene_to_packed(gameover_scene)
	else :
		if falling_distance >= 100:
			get_tree().set_meta("level_scene", get_tree().current_scene.scene_file_path)
			get_tree().change_scene_to_packed(gameover_scene)

	
