extends DobleStateMachine

func _ready():
	add_state('idle')
	add_state('run')
	add_state('jump')
	add_state('fall')
	add_state('glide')
	add_state('dash')
	add_state('dead')
	call_deferred('set_state', states.blue)
	add_state2('blue')
	add_state2('orange')
	add_state2('purple')


func _state_logic(delta):
	pass
	
func _state2_logic(delta):
	pass

func _get_transition(delta):
	return null
	
func _get_transition2(delta):
	return null
	
func _enter_state(new_state, old_state):
	pass
	
func _enter_state2(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
	
func _exit_state2(old_state, new_state):
	pass
