extends DobleStateMachine

func _ready():
	add_state('idle')
	add_state('run')
	add_state('jump')
	add_state('fall')
	add_state('dash')
	call_deferred('set_state', states.idle)
	add_state2('blue')
	add_state2('orange')
	add_state2('purple')
	call_deferred('set_state2', states2.blue)


func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_friction()
	parent._apply_movement()
	
func _state2_logic(delta):
	pass

func _input(event):
	if [states.idle, states.run].has(state):
		if event.is_action_pressed('ui_up'):
			parent.velocity.y = -parent.jump_speed
			pass
		if not [states.dash].has(state):
			if event.is_action_pressed("special"):
				parent.velocity.x += sign(parent.velocity.x) * 1000
			

func _get_transition(delta):
	var on_floor = parent.is_on_floor()
	match state:
		states.idle:
			if !on_floor:
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
					return states.run
		states.run:
			if !on_floor:
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			if parent.velocity.x == 0:
				return states.idle
		states.jump:
			if on_floor:
				if parent.velocity.x == 0: 
					return states.idle
				else: 
					return states.run
			else:
				if parent.velocity.y > 0: 
					return states.fall
		states.fall:
			if on_floor:
				if parent.velocity.x == 0: 
					return states.idle
				else: 
					return states.run
			else:
				if parent.velocity.y < 0: 
					return states.jump
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
