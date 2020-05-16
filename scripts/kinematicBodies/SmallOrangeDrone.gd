extends Drone


var ready = false
var is_timer_ready = false
onready var ready_timer = get_node('ReadyTimer') as Timer


func _ready():
	._ready()
	set_color_layer(1)
	set_exp_transform(1.5)


func _supra_jump(direction):
	velocity = direction * 600
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_ActivationArea_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		ready = true


func _on_ActivationArea_body_exited(body):
	if body in get_tree().get_nodes_in_group("drone_target"):
		ready = false


func _on_ReadyTimer_timeout():
	is_timer_ready = true
	ready_timer.stop()


func take_damage():
	_die()
	
