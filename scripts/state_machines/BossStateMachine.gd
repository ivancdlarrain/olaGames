extends DroneStateMachine

onready var color = get_parent().get_node("ColorState")

func _ready():
	._ready()
	add_state('idle')
	add_state('chase')
	add_state('main')
	add_state('secondary')
	add_state('recovery')
	add_state('changing_color')
	call_deferred('set_state', states.idle)


func _state_logic(delta):
	._state_logic(delta)
	match state:
		states.idle:
			parent.apply_deaccel()
		
		states.chase:
			parent.horizontal_movement(ray_direction.x > 0)
		
		states.main:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					pass
				
				color.states.purple:
					pass
		
		states.secondary:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					pass
				
				color.states.purple:
					pass
		
		states.recovery:
			pass
		
		states.changing_color:
			pass


func _get_transition(delta):
	match state:
		states.idle:
			pass
		
		states.chase:
			if parent.player_on_range():
				if randi()%3+1 > 1:
					return states.main
				
				else:
					return states.secondary
		
		states.main:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					pass
				
				color.states.purple:
					pass
		
		states.secondary:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					pass
				
				color.states.purple:
					pass
		
		states.recovery:
			pass
		
		states.changing_color:
			pass
		
	return null


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
		
		states.chase:
			pass
		
		states.main:
			pass
		
		states.secondary:
			pass
		
		states.recovery:
			pass
		
		states.changing_color:
			pass


func _exit_state(old_state, new_state):
	match old_state:
		states.idle:
			pass
		
		states.chase:
			pass
		
		states.main:
			pass
		
		states.secondary:
			pass
		
		states.recovery:
			pass
		
		states.changing_color:
			pass
