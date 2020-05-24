extends Drone

var enemy_in_range = false
onready var charge_timer = $ChargeTimerTest
onready var fire_timer = $FireTimerTest
onready var cooldown = $FireCD
onready var lights = $Sprite2
const LASER_SCENE = preload("res://assets/entities/drone/LaserBeam.tscn")

func _patrol(delta):
	pass

func _ready():
	print("Drone ready")
	
	
	._ready()

func _fire(pos):
	var laser = LASER_SCENE.instance()
	laser.position = position
	laser.cast_to = pos - position
	get_parent().add_child(laser)



func _on_DetectionCone_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		enemy_in_range = true
		print("Enemy entered firing cone")


func _on_DetectionCone_body_exited(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		enemy_in_range = false
		print("Enemy left firing cone")
