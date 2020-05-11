extends "res://state_machine/state.gd"

var facing_right = true
var on_floor = false
var accel = 3.0
var deaccel = 6.0
var max_speed = 300
func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("WASD_right")) - int(Input.is_action_pressed("WASD_left"))
	return input_direction

func update_facing():
	if Input.is_action_pressed("WASD_left") and not Input.is_action_pressed("WASD_right"):
		if facing_right:
			owner.scale.x *= -1
		facing_right = false
	if Input.is_action_pressed("WASD_right") and not Input.is_action_pressed("WASD_left"):
		if not facing_right:
			owner.scale.x *= -1
		facing_right = true
