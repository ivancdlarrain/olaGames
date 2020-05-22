extends DroneStateMachine


func _ready():
	add_state("idle")
	add_state("patrol")
	add_state("fire")
	call_deferred('set_state', states.idle)
	._ready()

func _state_logic(delta):
	._state_logic(delta)
	
func _get_transition(delta):
	match state:
		states.idle:
			if parent.enemy_in_range:
				return states.patrol
		states.patrol: 
			if parent.charge_timer.is_stopped():
				return states.fire
			else:
				if !parent.enemy_in_range:
					return states.idle
		states.fire:
			if parent.fire_timer.is_stopped():
				if !parent.enemy_in_range:
					return states.idle
				else:
					return states.patrol
					
				
				
		
	return null
	
func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			#Play deactivation animation
			parent.playback.travel("idle")
		states.patrol:
			#Play patrol anim and then start patrol
			print("Enemy entered detection area, starting patrol...")
			parent.playback.travel("move")
			parent.charge_timer.start()
		states.fire:
			print("Firing!")
			parent.fire_timer.start() #Placeholder timer to simulate firing
func _exit_state(old_state, new_state):
	match old_state:
		states.fire:
			print("Stopped Firing")
			#Why does it print before the exit state one ? !!!
			
	
