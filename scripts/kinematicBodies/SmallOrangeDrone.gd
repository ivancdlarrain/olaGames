extends KinematicBody2D


const gravity = 1000
var velocity = Vector2()
const deaccel = 200



func _apply_gravity(delta):
	velocity.y += gravity * delta


func _apply_friction():
	var s = sign(velocity.x)
	velocity.x -= sign(velocity.x) * deaccel
	if sign(velocity.x) != s: velocity.x = 0


func _apply_movement():
	velocity = move_and_slide(velocity, Vector2.UP)
	