extends DroneStateMachine


func _ready():
	add_state("idle")
	add_state("patrol")
	add_state("charge")
	add_state("fire")
	._ready()

func _state_logic(delta):
	._state_logic(delta)
	
func _get_transition(delta):
	match state:
		states.idle:
			if found:
				return states.patrol
		states.patrol:
			if parent.enemy_in_range:
				return states.charge
		states.charge:
			if $ChargeTimerTest.is_finished():
				return states.fire
		states.fire:
			if found:
				return states.patrol
				#TO DO: Add a cooldown to the laser so it doesn't shoot again instantly
			else:
				return states.idle
						
	return null
	
func _enter_state(new_state, old_state):
	match state:
		states.idle:
			#Play deactivation state
			pass
		states.patrol:
			#Play patrol anim and then start patrol
			pass
		states.charge:
			$ChargeTimerTest.start()
func _exit_state(old_state, new_state):
	pass
	
