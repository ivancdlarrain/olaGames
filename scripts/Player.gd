extends KinematicBody2D

# Script for player character. Handles basic movement, with complex interactions handled by the MovementState
# and ColorState state machines.

#------- Variables for character movement -------#

const UP = Vector2(0, -1)
var velocity = Vector2()
export var jump_speed = 400
export var grav = 1000
export var glide_grav = 300
export var default_grav = 1000
export var max_speed = 300

var move_direction = 0
var double_jump_direction = Vector2()
var facing_right = true
var accel = 3.0
var deaccel = 6.0


#------- Bool values for state logic -------#

var dashing = false
var gliding = false
var jump_pressed = false
var on_floor = false
var no_input = true
var double_jump = true
var can_jump = true

#------- Timers -------#

onready var dash_cd = $DashCooldown
onready var c_timer = $CoyoteTimer
onready var j_timer = $JumpWindow

#------- Animation -------#
onready var playback = $AnimationTree.get("parameters/playback")

var was_on_floor = false


func _ready():
	$MovementState.connect("use_ground_collision", self, "on_ground_collision")

# interpreting PlayerState signals:


	# collision signals
func on_ground_collision(boolean):
		$GroundCollisionShape.disabled = !boolean
		$AirCollisionShape.disabled = boolean

# Movement code:

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
		if [$MovementState.states.run].has($MovementState.state):
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
	jump_pressed = true
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
				_die()
		

func check_death(collision, delta):
	var tile_map = collision.collider as TileMap
#	print(tile_map.get_cellv(tile_map.world_to_map(collision.position + delta - tile_map.position)))
	return tile_map.get_cellv(tile_map.world_to_map(collision.position + delta - tile_map.position)) == 1


func _die():
	get_tree().reload_current_scene()
	


#Save Game

func save():
	var save_dict = {
		scene_path = get_owner().filename
		
		#FIXME: We need to find a way to make sure the JSON file generated reads the position AFTER the scene.
		#The way Godot converts to JSON doesn't assure the dictionary stays in order
#		pos = {
#			x = get_position().x, 
#			y = get_position().y
#		},
		
	}
	return save_dict
