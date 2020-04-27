extends KinematicBody2D

var velocity = Vector2()
export var move_speed = 300
export var jump_speed = 500
export var grav = 1000
export var max_speed = 1000



func _ready():
	pass


func _physics_process(delta):
	
	#Apply gravity
	
	velocity.y += delta * grav
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var on_floor = is_on_floor()
	
	if Input.is_action_just_pressed("ui_up") and on_floor:
		velocity.y = -jump_speed
	
	var target_vel = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * move_speed
	dash_input()
	velocity.x = lerp(velocity.x, target_vel, 0.2)

func dash_input():
	if Input.is_action_just_pressed("dash"):
		velocity.x += 1000
