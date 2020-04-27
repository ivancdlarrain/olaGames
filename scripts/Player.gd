extends KinematicBody2D

var velocity = Vector2()
export var move_speed = 300
export var jump_speed = 500
export var grav = 1000
export var max_speed = 100

var accel = 3.0
var deaccel = 6.0

var facing_right = true

func _ready():
	pass



func _physics_process(delta):
	
	#Apply gravity
	
	velocity.y += delta * grav
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var on_floor = is_on_floor()
	
	if Input.is_action_just_pressed("ui_up") and on_floor:
		velocity.y = -jump_speed
	
	var target_vel = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	print(target_vel)
	
	if abs(velocity.x) < max_speed:
		
		
		velocity.x = velocity.x + target_vel * max_speed / accel
		if abs(velocity.x) > max_speed:
			velocity.x = sign(velocity.x) * max_speed
	
	# Deaccel
	if not bool(target_vel) or abs(velocity.x) > max_speed:
		print("Deaccel")
		var v_sign = sign(velocity.x)
		if v_sign != 0:
			velocity.x = velocity.x - v_sign * max_speed / deaccel
			if sign(velocity.x) != v_sign:
				velocity.x = 0
	
	dash_input()
	
	
	#Animation
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		if facing_right:
			scale.x *= -1
		facing_right = false
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		if not facing_right:
			scale.x *= -1
		facing_right = true

func dash_input():
	if Input.is_action_just_pressed("dash"):
		velocity.x += sign(velocity.x) * 200
