extends KinematicBody2D

#movement:
const MAX_SPEED = 100
const SPEED_INCREASE = 10
const DEACCEL = 5
#animation:
var facing_right = false
#detection:
var enemy_in_range = false
#doing stuff:
var activated = false



func _ready():
	set_color_layer(2)
	set_exp_transform(5)
	playback.start('idle')


# for movement:

func apply_movement(direction):
	velocity += SPEED_INCREASE * direction
	if velocity.distance_to(Vector2(0, 0)) > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	velocity = move_and_slide(velocity)
	# Animation:
	if velocity.x > 0 and !facing_right:
		scale.x *= -1
		$DetectionRay.scale.x *= -1
		facing_right = true
	elif velocity.x < 0 and facing_right:
		scale.x *= -1
		$DetectionRay.scale.x *= -1
		facing_right = false
		


func apply_deaccel():
	var s = sign(velocity.x)
	velocity -= velocity.normalized() * DEACCEL
	if sign(velocity.x) != s:
		velocity = Vector2(0, 0)
	velocity = move_and_slide(velocity)


func take_damage():
	get_tree().get_node("BossFight").get_node("Boss").get_node("DroneStateMachine").remaining_drones -= 1
	_die()


func _on_ActivationArea_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		enemy_in_range = true


const EXPLOSION_SCENE = preload("res://assets/Area2D scenes/RegularExplosion.tscn")

# Movement variables
var gravity = 1000
var velocity = Vector2()
var deaccel = 2


# From Drone

# Animation
onready var playback = $AnimationTree.get("parameters/playback")
var color_layer = 0
var exp_transform = 1



func _apply_gravity(delta):
	velocity.y += gravity * delta


func _apply_friction():
	var s = sign(velocity.x)
	velocity.x -= sign(velocity.x) * deaccel
	if sign(velocity.x) != s: velocity.x = 0
	pass


func _apply_movement():
	velocity = move_and_slide(velocity, Vector2.UP)


func _die():
	var shake = get_tree().get_root().get_node("BossFight/Player/Camera2D/ScreenShake")
	var explosion = EXPLOSION_SCENE.instance() as Area2D
	explosion.position = position
	explosion.set_layer(color_layer)
	explosion.scale = Vector2(exp_transform, exp_transform)
	get_parent().add_child(explosion)
	shake._start(0.2, 15, 32)
	
	queue_free()


func set_color_layer(n):
	color_layer = n


func set_exp_transform(n):
	exp_transform = n


func set_gravity(n):
	gravity = n


func set_deaccel(n):
	deaccel = n


