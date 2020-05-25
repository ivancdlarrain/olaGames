extends Node2D

var max_length = 500
onready var beam = $Beam
onready var end = $End
onready var raycast = $RayCast2D
onready var beam_area = $Area2D
onready var beam_body = $Area2D/CollisionShape2D
var cast_to = Vector2()
var max_cast_to
var drone

func _ready():
	_ignore(drone)


func _physics_process(delta):

	var mouse_pos = get_local_mouse_position()
	max_cast_to = mouse_pos.normalized() * max_length
#	max_cast_to = cast_to.normalized() * max_length
	raycast.cast_to = max_cast_to
	if raycast.is_colliding():
		end.position = raycast.get_collision_point()
	
	else:
		end.global_position = raycast.cast_to
	beam.rotation = raycast.cast_to.angle()
	beam.region_rect.end.x = end.position.length()
	$Sprite.position = end.position
	if $Timer.is_stopped():
		beam_area.rotation = raycast.cast_to.angle()
		beam_body.position.x = end.position.length() / 2.0
		beam_body.shape.extents.x = end.position.length()
	
#	print(beam_body.get_global_transform().x)
	
	print(beam_body.shape.extents.x)
	
	


func _on_Area2D_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		body._die()

func _ignore(object):
	raycast.add_exception(object)
