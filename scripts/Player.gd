extends KinematicBody2D

var velocity = Vector2()
export var move_speed = 300
export var jump_speed = 500
export var grav = 1000
export var max_speed = 500
const UP = Vector2(0, -1)
var move_direction = 0

var accel = 3.0
var deaccel = 6.0

var facing_right = true

func _ready():
	pass

func _apply_movement():
	move_and_slide(velocity, UP)
	
func _apply_gravity(delta):
	velocity.y += delta * grav
	
func _handle_move_input():
	move_direction = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var new_velocity = velocity.x + move_direction * max_speed / accel
	if abs(new_velocity) < max_speed:
		velocity.x = new_velocity
	# Dash
	if Input.is_action_just_pressed("dash"):
		velocity.x += sign(velocity.x) * 1000
		
	# Facing:
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		if facing_right:
			scale.x *= -1
		facing_right = false
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		if not facing_right:
			scale.x *= -1
		facing_right = true


func _apply_friction():
	if not bool(move_direction) or abs(velocity.x) > max_speed:    # Si no está apretando para moverse o pasó el límite
		var v_sign = sign(velocity.x)
		if v_sign != 0:                                        # Si se está moviendo:
			velocity.x = velocity.x - v_sign * max_speed / deaccel
			if sign(velocity.x) != v_sign:
				velocity.x = 0
