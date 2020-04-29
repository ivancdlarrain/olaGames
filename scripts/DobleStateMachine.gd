extends Node
class_name DobleStateMachine

var state = null setget set_state
var previous_state = null
var state2 = null setget set_state2
var previous_state2 = null
var states = {}
var states2 = {}

onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			set_state(transition)

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
	
func set_state(new_state):
	previous_state = state
	state = new_state
	
	if previous_state != null:
		_exit_state(previous_state, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state)
		
func set_state2(new_state):
	previous_state2 = state2
	state2 = new_state
	
	if previous_state2 != null:
		_exit_state(previous_state2, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state2)
	
func add_state(state_name):
	states[state_name] = states.size()
	
func add_state2(state_name):
	states2[state_name] = state.size()



