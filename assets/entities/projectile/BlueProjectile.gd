extends Area2D


const PROJECTILE_SPEED = 500
var direction = Vector2()
var velocity = Vector2()
export var impact: PackedScene
	
		
func _fire(direction: Vector2):
	self.direction = direction
	$AnimationPlayer.play("travel")

func _physics_process(delta):
	velocity = direction * PROJECTILE_SPEED * delta
	translate(velocity)
	
#	if position.x or position.y >= 1000:
#		queue_free()


func _on_Projectile_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		body._die()
	set_physics_process(false)
	$AnimationPlayer.play("hit")

func _remove():
	queue_free()
