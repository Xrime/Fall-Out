extends Control

@export var rest_length := 50.0
@export var stiffness := 20.0
@export var damping_coeff := 4.0

@onready var player = $".."
@onready var ray = $RayCast2D
@onready var rope = $Line2D

var launched := false
var target : Vector2

func _process(delta: float) -> void:
	ray.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("grab"):
		launch()
	elif Input.is_action_just_released("grab"):
		retract()

	if launched:
		handle_rope(delta)
	else:
		rope.visible = false


func launch():
	if ray.is_colliding():
		target = ray.get_collision_point()
		launched = true
		rope.visible = true
		update_rope()


func retract():
	launched = false


func handle_rope(delta):
	var direction = (target - player.global_position).normalized()
	var distance = player.global_position.distance_to(target)
	var displacement = distance - rest_length

	if displacement > 0:
		var spring_force = direction * (stiffness * displacement)
		var velocity_along_rope = player.velocity.dot(direction)
		var damping_force = direction * (-damping_coeff * velocity_along_rope)
		player.velocity += (spring_force + damping_force) * delta

	update_rope()

func update_rope():
	rope.visible = true

	# Force rope to draw in world coordinates (fixes offset)
	rope.global_position = Vector2.ZERO

	# Find player's true anchor (center of sprite or top)
	var attach_offset = Vector2(0, -player.get_node("CollisionShape2D").shape.extents.y * 0.5)
	var player_anchor = player.global_position + attach_offset

	# Set rope start and end positions
	rope.set_point_position(0, player_anchor)
	rope.set_point_position(1, target)
