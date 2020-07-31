extends KinematicBody2D

# Script for player character. Handles basic movement, with complex interactions handled by the MovementState
# and ColorState state machines.

#------- Variables for character movement -------#

var UP = Vector2(0, -1)
var velocity = Vector2()
export var jump_speed = 400
export var grav = 1000
export var max_speed = 300

const purple_grav = 700
const default_grav = 1000

var move_direction = 0
var double_jump_direction = Vector2()
var facing_right = true
var accel = 3.0
var deaccel = 6.0

#------- Dash values -------#

var dash_max_distance = 120
var dash_distance = dash_max_distance
var dash_speed = 1200


#------- Bool values for state logic -------#

var dashing = false
var jump_pressed = false
var on_floor = false
var no_input = true
var double_jump = true

#------- Timers -------#

onready var dash_cd = $DashCooldown
onready var c_timer = $CoyoteTimer
onready var j_timer = $JumpWindow
onready var dj_cd = $DJumpCooldown

#------- Animation -------#
onready var playback = $AnimationTree.get("parameters/playback")

#------- Particles -------#
onready var dashParticles = $Particles2D

var was_on_floor = false

#------- State machines -------#
onready var colorstate = $ColorState

func _ready():
# warning-ignore:return_value_discarded
	$MovementState.connect("use_ground_collision", self, "on_ground_collision")


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
	velocity.y = min(velocity.y, grav/5)


func _handle_horizontal_move_input():
	var new_velocity 
	move_direction = -int(Input.is_action_pressed("WASD_left")) + int(Input.is_action_pressed("WASD_right"))
	no_input = !bool(move_direction)
	if on_floor:
		new_velocity = velocity.x + move_direction * max_speed / accel
	else:
		new_velocity = velocity.x + move_direction * max_speed / (accel * 1.5)
	if abs(new_velocity) < max_speed:
		velocity.x = new_velocity
	else: 
		if $MovementState.states.run == $MovementState.state:
			velocity.x = sign(velocity.x)*max_speed
		
	# Facing:
	var going_left = Input.is_action_pressed("WASD_left") and not Input.is_action_pressed("WASD_right")
	var going_right = Input.is_action_pressed("WASD_right") and not Input.is_action_pressed("WASD_left")
	if going_left:
		if facing_right:
			scale.x *= -1
			facing_right = false
	elif going_right:
		if not facing_right:
			scale.x *= -1
			facing_right = true


func _apply_friction():
	if no_input or abs(velocity.x) > max_speed:    # Si no está apretando para moverse o pasó el límite
		var v_sign = sign(velocity.x)
		if v_sign != 0:                                        # Si se está moviendo:
			velocity.x = velocity.x - v_sign * max_speed / (deaccel *(2 - int(on_floor))) # deaccel if on_floor else deaccel*2
			if sign(velocity.x) != v_sign:
				velocity.x = 0


func _wall_jump():
	if facing_right:
		double_jump_direction = Vector2(-400, -400 )
	else:
		double_jump_direction = Vector2(400, -400)
	
	velocity = double_jump_direction


func _tile_detection():	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		var collider = collision.collider
		if collider is TileMap:
			if collider in get_tree().get_nodes_in_group("deadly"):
				take_damage()


func take_damage():
	PlayerSfx.play_take_damage_sfx()
	_die()


func _die():
	# Controls will no longer work
	get_node('MovementState').set_physics_process(false)
	get_node('ColorState').set_physics_process(false)
	# The looks!
	$Sprite.modulate = Color(1, 1, 1)
	$Light2D.visible = false
	yield(get_tree().create_timer(.001), "timeout")
	playback.travel('death')

func _actually_die():
	get_tree().reload_current_scene()


func jump():
	velocity.y = -jump_speed


#Save Game

func save():
	#NEW NOTE: Maybe it's a better idea to just save the current scene and NOT the progress in that scene. AUTO-SAVE
	# when entered a new scene could be nice.
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


func _on_Guts_body_entered(body):
	if body != self:
		_die()
