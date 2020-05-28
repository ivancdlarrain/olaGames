extends Drone


onready var cooldown = $FireCD

export var projectile: PackedScene

const LASER_SCENE = preload("res://assets/entities/drone/LaserBeam.tscn")

func _patrol(delta):
	pass

func _ready():
	print("Drone ready")
	._ready()

func _fire(pos):
	pass



