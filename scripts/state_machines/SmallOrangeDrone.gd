extends DroneStateMachine


func _ready():
	add_state('idle')
	add_state('aggro')
	add_state('jump')
	call_deferred('set_state', states.idle)
	._ready()


func _state_logic(delta):
	parent._apply_friction()
	parent._apply_gravity(delta)
	parent._apply_movement()
	._state_logic(delta)


func _get_transition(_delta):
	match state:
		states.idle:
			if found:
				return states.aggro
		states.aggro:
			if !found:
				return states.idle
			if parent.ready and parent.is_timer_ready:
				return states.jump
		states.jump:
			pass
	return null


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.playback.travel('idle')
		states.aggro:
			parent.playback.travel('aggro')
			parent.is_timer_ready = false
			parent.ready_timer.start()
		states.jump:
			parent.playback.travel('jump')
			parent._supra_jump(ray_direction)


func _exit_state(old_state, new_state):
	match old_state:
		states.idle:
			pass
		states.aggro:
			pass
		states.jump:
			pass


func _on_DestructionArea_body_entered(_body):
	if state == states.jump:
		parent._die()
