extends KinematicBody2D
class_name Drone


const EXPLOSION_SCENE = preload("res://assets/Area2D scenes/RegularExplosion.tscn")

# Movement variables
var gravity = 1000
var velocity = Vector2()
var deaccel = 2

# Animation
onready var playback = $AnimationTree.get("parameters/playback")
var color_layer = 0
var exp_transform = 1


func _ready():
	playback.start('idle')


func _apply_gravity(delta):
	velocity.y += gravity * delta


func _apply_friction():
	var s = sign(velocity.x)
	velocity.x -= sign(velocity.x) * deaccel
	if sign(velocity.x) != s: velocity.x = 0
	pass


func _apply_movement():
	velocity = move_and_slide(velocity, Vector2.UP)


func take_damage():
	pass


func _die():
	var explosion = EXPLOSION_SCENE.instance() as Area2D
	explosion.position = position
	explosion.set_layer(color_layer)
	explosion.scale = Vector2(exp_transform, exp_transform)
	get_parent().add_child(explosion)
	queue_free()


func set_color_layer(n):
	color_layer = n


func set_exp_transform(n):
	exp_transform = n
