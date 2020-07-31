extends Drone

# Movement
const MAX_SPEED = 200
const SPEED_INCREASE = 10
const DEACCEL = 5
export var y_level = -400

# Animation
var facing_right = false
onready var trans_cd = $TransitionCD as Timer



# Detection
var enemy_on_range = false

# Combat:
var health = 120
const BLUE_DAMAGE = 30
const ORANGE_DAMAGE = 20
const PURPLE_DAMAGE = 10
const DAMAGE = [BLUE_DAMAGE, ORANGE_DAMAGE, PURPLE_DAMAGE]


const ORANGE_MAIN_SPEED = 1000
const ORANGE_RECOVERY_SPEED = 250


# State machines:
onready var combat = get_node("DroneStateMachine")
onready var color = get_node("ColorState")

# Scenes:
export var projectile: PackedScene
const PURPLE_EYE_DRONE = preload("res://assets/KinematicBodies/PurpleMinion.tscn")
onready var level = get_tree().get_root().get_node("BossFight")
onready var platforms = [
	level.get_node("Tiles/Platform1/Front"), level.get_node("Tiles/Platform1/Back"),
	level.get_node("Tiles/Platform2/Front"), level.get_node("Tiles/Platform2/Back"),
	level.get_node("Tiles/Platform3/Front"), level.get_node("Tiles/Platform3/Back")
]

func _ready():
	randomize()


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
	summon_explosion(position, color.state, 5)
	health -= DAMAGE[color.state]
	if health <= 0:
		health = 0
		_die()
	# Health bar animation should be here


func _die():
	# it should no longer move
	get_node("DroneStateMachine").set_physics_process(false)
	get_node('ColorState').set_physics_process(false)
	for i in range(10):
		var rel_pos = Vector2(randi()%3-1, randi()%3-1)
		var exp_size = randi()%5+1
		summon_explosion(position + rel_pos * 10, color.state, exp_size)
		yield(get_tree().create_timer(0.3), "timeout")
	modulate.a = 0
	# Boss won't dissapear after dying 
	


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


var finished_blue_main = false
func blue_main_attack():
	for i in range(60):
		fire()
		yield(get_tree().create_timer(0.05), "timeout")
	finished_blue_main = true
	


var finished_blue_secondary = false
func blue_secondary_attack():
	for i in range(10):
		fire()
		yield(get_tree().create_timer(0.125), "timeout")
	finished_blue_secondary = true


func orange_main_attack():
	# Movement:
	velocity = combat.ray_direction * ORANGE_MAIN_SPEED
	velocity = move_and_slide(velocity)


func orange_secondary_attack():
	orange_main_attack()


func purple_main_attack():
	for i in range(3):
		summon_PurpleMinion()
		yield(get_tree().create_timer(1.5), "timeout")


var finished_purple_secundary = false
func purple_secondary_attack():
	var x = randi()%3
	var fx = Vector2(2*x, 2*x + 1) # Contains platform index
	level.dissapear_platform(platforms[fx.x], platforms[fx.y])
	yield(get_tree().create_timer(1.5), "timeout")
	finished_purple_secundary = true


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


func summon_explosion(pos, layer, size):
	var shake = get_owner().get_node("Player/Camera2D/ScreenShake")
	var explosion = EXPLOSION_SCENE.instance() as Area2D
	explosion.position = pos
	explosion.set_layer(layer)
	explosion.scale = Vector2(size, size)
	get_parent().add_child(explosion)
	shake._start(0.2, 15, 32)


func summon_PurpleMinion():
	var minion = PURPLE_EYE_DRONE.instance()
	get_parent().add_child(PURPLE_EYE_DRONE.instance())


func fire():
	var temp = projectile.instance()
	temp.position = position
	get_owner().add_child(temp)
	temp._fire(combat.ray_direction)


