extends KinematicBody2D


func _tile_detection():	
#	print(get_slide_count())
	for index in get_slide_count():
		
		var collision = get_slide_collision(index)
		var collider = collision.collider
		if collider is TileMap:
			var death = check_death(collision, Vector2(-1, -1)) \
			or check_death(collision,  Vector2(-1, 1)) \
			or check_death(collision, Vector2(1, -1)) \
			or	check_death(collision, Vector2(1, 1))
			if death:
				_die()
		

func check_death(collision, delta):
	var tile_map = collision.collider as TileMap
#	print(tile_map.get_cellv(tile_map.world_to_map(collision.position + delta - tile_map.position)))
	return tile_map.get_cellv(tile_map.world_to_map(collision.position + delta - tile_map.position)) == 1


func _die():
	get_tree().reload_current_scene()
