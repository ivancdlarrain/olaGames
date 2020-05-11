extends "res://state_machine/state.gd"

var facing_right = true
var on_floor = false
var accel = 3.0
var deaccel = 6.0
var max_speed = 300

var velocity = Vector2()


func get_input_direction():
	var input_direction = 0
	input_direction = int(Input.is_action_pressed("WASD_right")) - int(Input.is_action_pressed("WASD_left"))
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

func apply_friction(input_dir):
	if not bool(input_dir) or abs(velocity.x) > max_speed:    # Si no está apretando para moverse o pasó el límite
		var v_sign = sign(velocity.x)
		if v_sign != 0:                                        # Si se está moviendo:
			velocity.x = velocity.x - v_sign * max_speed / deaccel
			if sign(velocity.x) != v_sign:
				velocity.x = 0
