extends Node2D

var max_length = 500
onready var beam = $Beam
onready var end = $End
onready var raycast = $RayCast2D
onready var beam_area = $Area2D
onready var beam_body = $Area2D/CollisionShape2D
var max_cast_to

#onready var beam_area = $Area2D
#onready var beam_body = $Area2D/CollisionShape2D as CollisionShape2D

func _physics_process(delta):
	var mouse_pos = get_local_mouse_position()
	max_cast_to = mouse_pos.normalized() * max_length
	raycast.cast_to = max_cast_to
	if raycast.is_colliding():
		end.position = raycast.get_collision_point() - position
	else:
		end.position = raycast.cast_to
	beam.rotation = raycast.cast_to.angle()
	beam.region_rect.end.x = end.position.length()
	$Sprite.position = end.position
	beam_area.rotation = raycast.cast_to.angle()
	beam_body.shape.extents.x = end.position.length()
#	print(beam_body.get_global_transform().x)
	beam_body.position.x = float(end.position.length()) / 2.0
	

func _start(x_pos, y_pos, max_length):
	max_cast_to = Vector2(x_pos, y_pos).normalized() * max_length
	
	pass
	
