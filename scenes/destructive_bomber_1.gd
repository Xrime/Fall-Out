extends Area2D

@export var radius := 2

func _ready() -> void:
	$AnimatedSprite2D2.play()

func _on_area_entered(area: Area2D) -> void:
	var tilemap = get_tree().current_scene.get_node_or_null("TileMap")
	if tilemap == null:
		return
	var local_pos = tilemap.to_local(global_position)
	var  tile_pos = tilemap.local_to_map(local_pos)
	
	for x in range(-radius, radius+1):
		for y in range(-radius, radius+1):
			var pos = tile_pos +Vector2i(x,y)
			tilemap.set_cell(0, pos , -1)
		
