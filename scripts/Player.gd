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
var can_jump = true
var accel = 3.0
var deaccel = 6.0
var facing_right = true
var dashing = false
var gliding = false
var jump_pressed = false
var on_floor = false
var no_input = true

onready var playback = $AnimationTree.get("parameters/playback")





onready var dash_cd = $DashCooldown
onready var c_timer = $CoyoteTimer
onready var j_timer = $JumpWindow
var was_on_floor = false

func _ready():
	$PlayerState.connect("color_changed", self, "on_color_changed")

func on_color_changed(new_color: String):
	$Sprite.modulate = ColorN(new_color)



func _apply_movement():
	velocity = move_and_slide(velocity, UP)
	on_floor = is_on_floor()
	
func _apply_gravity(delta):
	velocity.y += delta * grav

func _cap_gravity(delta):
	velocity.y += delta * grav
	velocity.y = min(velocity.y, 130)
	
func _handle_move_input():
	var new_velocity 
	move_direction = -int(Input.is_action_pressed("WASD_left")) + int(Input.is_action_pressed("WASD_right"))
	no_input = move_direction == 0
	if on_floor:
		new_velocity = velocity.x + move_direction * max_speed / accel
	else:
		new_velocity = velocity.x + move_direction * max_speed / (accel * 1.5)
	if abs(new_velocity) < max_speed:
		velocity.x = new_velocity
	else: 
		if [$PlayerState.states.run].has($PlayerState.state):
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

func _handle_animation():
	if on_floor:
		if abs(velocity.x) > 10.0 or not no_input:
			playback.travel("run")
#			$AnimationTree.set("parameters/run/TimeScale/scale", 2 * abs(linear_vel.x)/speed)
		else:
			playback.travel("idle")
	else:
		if velocity.y > 0:
			playback.travel("fall")
		else:
			playback.travel("jump")
		
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
		double_jump_direction = Vector2(-400, -400 )
	else:
		double_jump_direction = Vector2(400, -400)
	
	velocity = double_jump_direction

func remember_jump():
	yield(get_tree().create_timer(.1), "timeout")
	jump_pressed = false
	pass

# Game logic for tile detection:

export var blue_tile_map_path : NodePath
onready var blue_tile_map = get_node(blue_tile_map_path) as TileMap

export var orange_tile_map_path : NodePath
onready var orange_tile_map = get_node(orange_tile_map_path) as TileMap

export var purple_tile_map_path : NodePath
onready var purple_tile_map = get_node(purple_tile_map_path) as TileMap

var counter = 0

func _tile_detection():	
#	print(get_slide_count())
	for index in get_slide_count():
		
		var collision = get_slide_collision(index)
		var collider = collision.collider
		if collider is TileMap:
			var death = check_death(collision, Vector2(-1, -1)) \
			or check_death(collision,  Vector2(-1, 1)) \
			or check_death(collision, Vector2(1, -1)) \
			or	check_death(collision, Vector2(1, 1))
			if death:
				get_tree().reload_current_scene()
#		
		

func check_death(collision, delta):
	return (collision.collider as TileMap).get_cellv(purple_tile_map.world_to_map(collision.position + delta)) == 1
	

func _on_Area2D_body_entered(body):
	velocity.y = -1000


func _on_Area2D_mouse_entered():
	velocity.y = -1000
