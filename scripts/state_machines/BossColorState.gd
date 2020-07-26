extends StateMachine

var changing_color = false

func _ready():
	add_state("blue")
	add_state("orange")
	add_state("purple")
	call_deferred('set_state', states.purple)


func enter_layer(layer):
	parent.set_collision_layer_bit(layer, true)
	parent.set_collision_mask_bit(layer, true)


func exit_layer(layer):
	parent.set_collision_layer_bit(layer, false)
	parent.set_collision_mask_bit(layer, false)


func _get_transition(_delta):
	match state:
		states.blue:
			if changing_color:
				return states.orange
		
		states.orange:
			if changing_color:
				return states.purple
		
		states.purple:
			if changing_color:
				return states.blue
	
	return null


func _enter_state(new_state, _old_state):
	changing_color = false
	match new_state:
		states.blue:
			enter_layer(0)
		states.orange:
			enter_layer(1)
		states.purple:
			enter_layer(2)


func _exit_state(old_state, _new_state):
	pass

