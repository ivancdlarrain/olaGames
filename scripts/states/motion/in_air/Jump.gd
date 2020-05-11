extends "res://scripts/states/motion/motion.gd"

var grav = 1000
var jump_speed = 400
var enter_velocity = Vector2()
var horizontal_vel = 0.0


func initialize(velocity):
	enter_velocity = velocity

func enter():
	$AnimationTree.playback.travel("jump")
	owner.velocity.y = jump_speed

func update(delta):
	var input_dir = get_input_direction()
	update_facing()
	
	owner.velocity.y -= grav * delta
	
	horizontal_vel = owner.velocity.x + input_dir * max_speed / (accel * 1.5)
