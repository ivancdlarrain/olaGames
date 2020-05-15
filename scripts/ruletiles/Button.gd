extends StaticBody2D

export var tile_map_path : NodePath
onready var tile_map = get_node(tile_map_path) as TileMap
export var layer_bit : int
export var default_state: bool

var transparency1 = 1
var transparency2 = 0.5


func set_transparency(condition):
	if condition:
		tile_map.modulate.a = transparency1
	else:
		tile_map.modulate.a = transparency2

func _ready():
	$Area2D.set_collision_layer(get_collision_layer())
	$Area2D.set_collision_mask(get_collision_mask())
	tile_map.set_collision_layer_bit(layer_bit, default_state)
	tile_map.set_collision_mask_bit(layer_bit, default_state)
	set_transparency(default_state)
	
	
func _on_Area2D_body_entered(_body):
	$AnimationPlayer.play("starting")
	

func _on_AnimationPlayer_animation_finished(_anim_name):
	if len($Area2D.get_overlapping_bodies()) > 0:
		var new_state = !bool(tile_map.get_collision_layer_bit(layer_bit))
		set_transparency(new_state)
		tile_map.set_collision_layer_bit(layer_bit, new_state)
		tile_map.set_collision_mask_bit(layer_bit, new_state)
