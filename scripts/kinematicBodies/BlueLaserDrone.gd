extends Drone

var enemy_in_range = false
onready var charge_timer = $ChargeTimerTest
onready var fire_timer = $FireTimerTest
onready var cooldown = $FireCD

func _patrol(delta):
	pass

func _ready():
	print("Drone ready")
	._ready()




func _on_DetectionCone_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		enemy_in_range = true
		print("Enemy entered firing cone")


func _on_DetectionCone_body_exited(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		enemy_in_range = false
		print("Enemy left firing cone")
