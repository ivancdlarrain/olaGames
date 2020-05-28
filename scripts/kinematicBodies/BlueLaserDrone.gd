extends Drone


onready var cooldown = $FireCD

export var projectile: PackedScene


func _patrol(delta):
	pass

func _ready():
	print("Drone ready")
	._ready()

func _fire(pos: Vector2):
	var temp = projectile.instance()
	add_child(temp)
	print(pos.normalized())
	temp._fire(pos.normalized())



