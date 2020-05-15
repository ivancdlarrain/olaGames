extends KinematicBody2D


const EXPLOSION_SCENE = preload("res://assets/Area2D scenes/RegularExplosion.tscn")
const gravity = 1000
var velocity = Vector2()
const deaccel = 2
var ready = false
onready var playback = $AnimationTree.get("parameters/playback")
var is_timer_ready = false
onready var ready_timer = get_node('ReadyTimer') as Timer


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


func _supra_jump(direction):
	velocity = direction * 600
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_ActivationArea_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		ready = true


func _on_ActivationArea_body_exited(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		ready = false


func _on_ReadyTimer_timeout():
	print('Timer ended')
	is_timer_ready = true
	ready_timer.stop()


func take_damage():
	_die()


func _die():
	var explosion = EXPLOSION_SCENE.instance() as Area2D
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()
	
