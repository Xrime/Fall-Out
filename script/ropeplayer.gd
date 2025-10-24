extends CharacterBody2D

@onready var player = $FlipNode/player
@onready var flip_node = $FlipNode
@onready var rope_ray_cast = $FlipNode/ropeRayCast2D

const ROPE = preload("res://scenes/rope.tscn")

const SPEED := 100
const JUMP_VELOCITY := -350

var gravity := 980
var onRope := false
var ropeBody: Node2D

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not is_on_floor() and not onRope:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept"):
		if onRope:
			_remove_rope()
			velocity.y = JUMP_VELOCITY
		elif not is_on_floor():
			_use_rope()
		elif is_on_floor():
			velocity.y = JUMP_VELOCITY

	if onRope and ropeBody:
		rotation_degrees = ropeBody.rotation_degrees + 100
		var hand_offset = Vector2((7 if flip_node.scale.x == -1 else -7), 0)
		global_position = ropeBody.get_player_hang_position() + hand_offset
	else:
		rotation_degrees = 0
		var direction = Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _use_rope() -> void:
	if not rope_ray_cast.is_colliding():
		return
	onRope = true

	var colliding_point = rope_ray_cast.get_collision_point()
	var ropeNode = ROPE.instantiate()
	get_parent().add_child(ropeNode)

	if ropeNode.has_method("set_rope"):
		ropeNode.set_rope(global_position, colliding_point)
		ropeBody = ropeNode
	else:
		push_error("Rope scene has no set_rope()! Make sure rope.gd is attached to its root node.")
		onRope = false
		ropeNode.queue_free()

func _remove_rope() -> void:
	onRope = false
	var rope = get_tree().get_first_node_in_group("rope")
	if rope:
		rope.queue_free()
	ropeBody = null
