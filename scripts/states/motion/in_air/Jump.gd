extends "res://scripts/states/motion/motion.gd"

var grav = 1000
var jump_speed = 400
var enter_velocity = Vector2()


func initialize(velocity):
	enter_velocity = velocity
	

func enter():
#	$AnimationTree.playback.travel("jump")
	velocity.y = -jump_speed
	print("Entering Jump")

func update(delta):
	var input_dir = get_input_direction()
	update_facing()
	
	print(velocity.y)
	velocity.y += grav * delta
	
#	enter_velocity.x = velocity.x + input_dir * max_speed / (accel * 1.5)
	
	
	apply_friction(input_dir)
	
	velocity = owner.move_and_slide(enter_velocity, Vector2.UP)
	
	if velocity.y == 0:
		emit_signal("finished", "Fall")
				


