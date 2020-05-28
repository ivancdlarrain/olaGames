extends Node2D


const PROJECTILE_SPEED = 1000

func _on_Area2D_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		body._die()
	else:
		#Do something when crashing
		pass
		
func _fire(direction: Vector2):
	pass
