extends Drone

# Movement
const MAX_SPEED = 200
const SPEED_INCREASE = 10
const DEACCEL = 5
export var y_level = -400

# Animation
var facing_right = false

# Detection
var enemy_on_range = false

# Combat:
var health = 200
const BLUE_DAMAGE = 30
const ORANGE_DAMAGE = 20
const PURPLE_DAMAGE = 10

const ORANGE_MAIN_SPEED = 500
const ORANGE_RECOVERY_SPEED = 50

# Platforms that the boss will be able to control:
export var platform_1 : NodePath
export var platform_2 : NodePath
export var platform_3 : NodePath
onready var tile_map_1 = get_node(platform_1) as TileMap
onready var tile_map_2 = get_node(platform_2) as TileMap
onready var tile_map_3 = get_node(platform_3) as TileMap


# State machines:
onready var combat = get_node("DroneStateMachine")
onready var color = get_node("ColorState")


func _ready():
	pass


# Functions:

#   Movement:

func horizontal_movement(move_right):
	# Movement:
	var dir = -1 + 2*int(move_right)
	velocity.x += SPEED_INCREASE * dir
	if abs(velocity.x) > MAX_SPEED:
		velocity.x = sign(velocity.x) * MAX_SPEED
	velocity = move_and_slide(velocity)
	
	# Animation:
	if velocity.x > 0 and !facing_right:
		scale.x *= -1
		$DetectionRay.scale.x *= -1
		facing_right = true
	elif velocity.x < 0 and facing_right:
		scale.x *= -1
		$DetectionRay.scale.x *= -1
		facing_right = false


func apply_deaccel():
	var s = sign(velocity.x)
	velocity.x -= s * DEACCEL
	# if changed direction while deaccelerating:
	if sign(velocity.x) != s:
		velocity.x = 0
	velocity = move_and_slide(velocity)

#   Attack:

func take_damage():
	match color.state:
		color.states.blue:
			health -= BLUE_DAMAGE
		color.states.orange:
			health -= ORANGE_DAMAGE
		color.states.purple:
			health -= PURPLE_DAMAGE
	if health < 0:
		health = 0
		_die()
	# Health bar animation should be here


func _die():
	# Special boss animation/multiple explosions
	pass


func player_on_range():
	# This function checks if boss can attack the player
	match color.state:
		color.states.blue:
			return true
		
		color.states.orange:
			return true
		
		color.states.purple:
			return true


func back_to_y_level():
	# Movement:
	velocity = Vector2(0, -ORANGE_RECOVERY_SPEED)
	velocity = move_and_slide(velocity)


func blue_main_attack():
	pass


func blue_secondary_attack():
	pass


func orange_main_attack():
	# Movement:
	velocity = combat.ray_direction * ORANGE_MAIN_SPEED
	velocity = move_and_slide(velocity)


func orange_secondary_attack():
	pass


func purple_main_attack():
	pass


func purple_secondary_attack():
	pass


func main_attack():
	match color.state:
		color.states.blue:
			blue_main_attack()
		
		color.states.orange:
			orange_main_attack()
		
		color.states.purple:
			purple_main_attack()


func secondary_attack():
	match color.state:
		color.states.blue:
			blue_secondary_attack()
		
		color.states.orange:
			orange_secondary_attack()
		
		color.states.purple:
			purple_secondary_attack()

