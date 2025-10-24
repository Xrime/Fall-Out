extends Node2D

var tileSize := 16
var maxSwingDegree := 45
var changeRotation := -1
var initialRotation := 0.0

func _ready() -> void:
	add_to_group("rope")

func _physics_process(delta: float) -> void:
	rotation_degrees += changeRotation
	if rotation_degrees >= initialRotation + maxSwingDegree:
		changeRotation = -1
	elif rotation_degrees <= initialRotation - maxSwingDegree:
		changeRotation = 1

func set_rope(startPosition: Vector2, endPosition: Vector2) -> void:
	var distance = startPosition.distance_to(endPosition)
	global_position = endPosition
	look_at(startPosition)
	rotation_degrees += 90
	initialRotation = rotation_degrees

	if rotation_degrees < 100:
		changeRotation = 1
	for i in range(int(distance / tileSize) + 1):
		var newRopeTile = $MeshInstance2D.duplicate()
		add_child(newRopeTile)
		newRopeTile.position = Vector2(0, -(i * tileSize))cd 
	var markerNode := Marker2D.new()
	markerNode.name = "playerPositionMarker"
	add_child(markerNode)
	markerNode.global_position = startPosition

func get_player_hang_position() -> Vector2:
	return get_node("playerPositionMarker").global_position
