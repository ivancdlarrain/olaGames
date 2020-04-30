extends KinematicBody2D

var velocity = Vector2()
export var jump_speed = 400
export var grav = 1000
export var glide_grav = 300
export var default_grav = 1000
export var max_speed = 300
const UP = Vector2(0, -1)
var move_direction = 0
var colour_switch = 0
var double_jump = true
var double_jump_direction = Vector2()

var accel = 3.0
var deaccel = 6.0

var facing_right = true

func _ready():
	pass

func _apply_movement():
	velocity = move_and_slide(velocity, UP)
	
func _apply_gravity(delta):
	velocity.y += delta * grav

func _cap_gravity(delta):
	velocity.y += delta * grav
	velocity.y = min(velocity.y, 130)
	
func _handle_move_input():
	var new_velocity 
	move_direction = -int(Input.is_action_pressed("WASD_left")) + int(Input.is_action_pressed("WASD_right"))
	if is_on_floor():
		new_velocity = velocity.x + move_direction * max_speed / accel
	else:
		new_velocity = velocity.x + move_direction * max_speed / (accel * 1.5)
	if abs(new_velocity) < max_speed:
		velocity.x = new_velocity
	else: 
		velocity.x = sign(velocity.x)*max_speed
		
	# Facing:
	if Input.is_action_pressed("WASD_left") and not Input.is_action_pressed("WASD_right"):
		if facing_right:
			scale.x *= -1
		facing_right = false
	if Input.is_action_pressed("WASD_right") and not Input.is_action_pressed("WASD_left"):
		if not facing_right:
			scale.x *= -1
		facing_right = true

		
func _handle_color_input():
	colour_switch += -int(Input.is_action_just_pressed("switch_left")) + int(Input.is_action_just_pressed("switch_right"))


func _apply_friction():
	if not bool(move_direction) or abs(velocity.x) > max_speed:    # Si no está apretando para moverse o pasó el límite
		var v_sign = sign(velocity.x)
		if v_sign != 0:                                        # Si se está moviendo:
			velocity.x = velocity.x - v_sign * max_speed / deaccel
			if sign(velocity.x) != v_sign:
				velocity.x = 0
				
func _wall_jump():
	if facing_right:
		double_jump_direction = Vector2(-1500, -400 )
	else:
		double_jump_direction = Vector2(1500, -400)
	
	velocity = double_jump_direction
