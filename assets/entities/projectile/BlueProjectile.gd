extends Area2D


const PROJECTILE_SPEED = 200
var direction = Vector2()
var velocity = Vector2()

func _on_Area2D_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		body._die()
		queue_free()
		
func _fire(direction: Vector2):
	self.direction = direction

func _physics_process(delta):
	velocity = direction * PROJECTILE_SPEED * delta
	translate(velocity)
	
#	if position.x or position.y >= 1000:
#		queue_free()
