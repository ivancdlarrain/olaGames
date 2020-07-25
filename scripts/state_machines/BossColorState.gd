extends StateMachine


func _ready():
	add_state("blue")
	add_state("orange")
	add_state("purple")
	call_deferred('set_state', states.blue)


func _state_logic(delta):
	pass


func _get_transition(_delta):
	match state:
		states.blue:
			return null
		
		states.orange:
			return null
		
		states.purple:
			return null
	
	return null


func _enter_state(new_state, _old_state):
	pass


func _exit_state(old_state, _new_state):
	pass

