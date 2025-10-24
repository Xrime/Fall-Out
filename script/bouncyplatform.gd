extends Area2D

@export var boumce_force: float = -600.0



func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.velocity.y = boumce_force
		
