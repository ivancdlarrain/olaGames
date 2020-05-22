extends DroneStateMachine


func _ready():
	add_state("idle")
	add_state("patrol")
	add_state("charge")
	add_state("fire")
	call_deferred('set_state', states.idle)
	._ready()

func _state_logic(delta):
	if states.fire == state:
		print("Firing!")
	._state_logic(delta)
	
func _get_transition(delta):
	match state:
		states.idle:
			if looking_for_player:
				return states.patrol
		states.patrol:
			if parent.enemy_in_range and parent.cooldown.is_stopped():
				return states.charge
		states.charge:
			if parent.charge_timer.is_stopped():
				return states.fire
		states.fire:
			if parent.fire_timer.is_stopped():
				if looking_for_player:
					return states.patrol
					#TO DO: Add a cooldown to the laser so it doesn't shoot again instantly
				else:
					return states.idle
						
	return null
	
func _enter_state(new_state, old_state):
	match state:
		states.idle:
			#Play deactivation animation
			parent.playback.travel("idle")
		states.patrol:
			#Play patrol anim and then start patrol
			print("Enemy entered detection area, starting patrol...")
			parent.playback.travel("aggro")
		states.charge:
			print("Charging...")
			parent.charge_timer.start() #Placeholder timer to simulate charge animation
		states.fire:
			parent.fire_timer.start() #Placeholder timer to simulate firing
func _exit_state(old_state, new_state):
	match state:
		states.fire:
			print("Firing stopped")
			parent.cooldown.start()
			
	
