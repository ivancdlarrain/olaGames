extends Drone

#movement:
const MAX_SPEED = 50
const SPEED_INCREASE = 10
const DEACCEL = 5
#animation:
var facing_right = false
#detection:
var enemy_in_range = false
#doing stuff:
var activated = false



func _ready():
	set_color_layer(2)
	set_exp_transform(2)


# for movement:

func apply_movement(direction):
	velocity += SPEED_INCREASE * direction
	if velocity.distance_to(Vector2(0, 0)):
		velocity = velocity.normalized() * MAX_SPEED
	velocity = move_and_slide(velocity)
	# Animation:
	if velocity.x > 0 and !facing_right:
		scale.x *= -1
		facing_right = true
	elif velocity.x < 0 and facing_right:
		scale.x *= -1
		facing_right = false
		


func apply_deaccel():
	var s = sign(velocity.x)
	velocity -= velocity.normalized() * DEACCEL
	if sign(velocity.x) != s:
		velocity = Vector2(0, 0)
	velocity = move_and_slide(velocity)


func take_damage():
	_die()


func _on_ActivationArea_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		enemy_in_range = true



#FIXME: this function is never used, therefore, the drone will never move or explode. :c
func _on_AnimationPlayer_animation_finished(anim_name):
	print("IT'S BEING USED!")
	print('anim_name')
	match anim_name:
		"activation":
			activated = true
		"deactivation":
			activated = false
		"explosion":
			_die()
	
