extends StateMachine
class_name DroneStateMachine


# These following arguments will be used to detect the player  
# To use all of these, the Drone will need to have:
# -> An Area2D named DetectionArea
# -> A RayCast2D named "DetectionRay"
#
# Also, in the ready function, it will HAVE to be called as ._ready() instead of just _ready()


onready var detection_area = parent.get_node("DetectionArea") as Area2D  # has to have a radius
onready var raycast = parent.get_node("DetectionRay") as RayCast2D
onready var detection_range = detection_area.get_node("CollisionShape2D").shape.radius as int
var player
var ray_direction = Vector2()    # This will tell the raycast the direction it should look at
var looking_for_player = false   # We will use this variable to check if we want to use look_for_player function
var found = false                # This flag will tell us if raycast collided with player or not


func _ready():
	detection_area.connect("body_entered", self, "on_body_entered")
	detection_area.connect("body_exited", self, "on_body_exited")


func on_body_entered(body: Node):
	if body in get_tree().get_nodes_in_group("drone_target"):
#		print("Player entered")
		player = body
		looking_for_player = true


func on_body_exited(body: Node):
	if body in get_tree().get_nodes_in_group("drone_target"):
#		print("Player exited")
		looking_for_player = false


func _get_ray_direction(body):
	var player_pos = body.get_position()
	var self_pos = parent.get_position()
	ray_direction = (player_pos - self_pos).normalized()


func look_for_player():
	_get_ray_direction(player)
	raycast.cast_to = detection_range * ray_direction
	if raycast.is_colliding() and raycast.get_collider() in get_tree().get_nodes_in_group('drone_target'):
		found = true
	else:
		found = false


func _state_logic(_delta):
	if looking_for_player:
		look_for_player()
	else:
		found = false
