extends KinematicBody2D


const gravity = 1000
var velocity = Vector2()
const deaccel = 200
var ready = false
onready var playback = $AnimationTree.get("parameters/playback")
var is_timer_ready = false
onready var ready_timer = get_node('ReadyTimer') as Timer


func _ready():
	playback.start('idle')


func _apply_gravity(delta):
	velocity.y += gravity * delta


func _apply_friction():
#	var s = sign(velocity.x)
#	velocity.x -= sign(velocity.x) * deaccel
#	if sign(velocity.x) != s: velocity.x = 0
	pass


func _apply_movement():
	velocity = move_and_slide(velocity, Vector2.UP)


func _supra_jump(direction):
	velocity = direction * 600
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_ActivationArea_body_entered(body):
	if body.name == "Player":        # This will be changed for "in group player"
		ready = true


func _on_ActivationArea_body_exited(body):
	if body.name == "Player":
		ready = false


func _on_ReadyTimer_timeout():
	print('Timer ended')
	is_timer_ready = true
	ready_timer.stop()
	
