extends StateMachine

signal color_changed
signal layer_entered
signal layer_exited


func _ready():
	add_state('blue')
	add_state('orange')
	add_state('purple')
	call_deferred('set_state', states.blue)


func _state_logic(delta):
	parent._handle_color_input_arrkeys()   # Future update: move that code to this script.


func _get_transition(delta):
	var colour = parent.colour_switch
	match colour:
		0:
			return states.blue
		1:
			return states.orange
		2:
			return states.purple


func _enter_state(new_state, old_state):
	match new_state:
		states.blue:
			emit_signal("color_changed", Color(0, 0.972549, 1))
			emit_signal("layer_entered", 0)
		states.orange:
			emit_signal("color_changed", Color(1, 0.529412, 0))
			emit_signal("layer_entered", 1)
		states.purple:
			emit_signal("color_changed",Color(0.85098, 0, 1))
			emit_signal("layer_entered", 2)


func _exit_state(old_state, new_state):
	# This function removes the player from the corresponding collision layer 
	# by using signals connected to Player.gd
	match old_state:
		states.blue:
			emit_signal("layer_exited", 0)
		states.orange:
			emit_signal("layer_exited", 1)
		states.purple:
			emit_signal("layer_exited", 2)
