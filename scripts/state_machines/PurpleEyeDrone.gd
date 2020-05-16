extends DroneStateMachine


func _ready():
	add_state('idle')
	add_state('aggro')
	add_state('explosion')
	call_deferred('set_state', states.idle)
	._ready()


func _state_logic(delta):
	if states.aggro == state and parent.playback.get_current_node() == 'aggro':
		parent.apply_movement(ray_direction)
	elif states.idle == state:
		parent.apply_deaccel()
	._state_logic(delta)


func _get_transition(_delta):
	match state:
		states.idle:
			if parent.enemy_in_range:
				return states.explosion
			elif found:
				return states.aggro
		states.aggro:
			if !found:
				return states.idle
			if parent.enemy_in_range:
				return states.explosion
	return null


func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent.playback.travel('idle')
		states.aggro:
			parent.playback.travel('aggro')
		states.explosion:
			parent.playback.travel('explosion')
			yield(get_tree().create_timer(.6), "timeout")
			parent._die()


func _exit_state(old_state, _new_state):
#	match old_state:
#		states.idle:
#			pass
#		states.aggro:
#			pass
#		states.explosion:
#			pass
	pass
