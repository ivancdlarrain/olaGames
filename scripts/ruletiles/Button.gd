extends StaticBody2D

export var tile_map_path : NodePath
onready var tile_map = get_node(tile_map_path) as TileMap
export var layer_bit : int

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("starting")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if len($Area2D.get_overlapping_bodies()) > 0:
		var new_state = !bool(tile_map.get_collision_layer_bit(layer_bit))
		print(new_state)
		tile_map.set_collision_layer_bit(layer_bit, new_state)
		tile_map.set_collision_layer_bit(layer_bit, new_state)
