extends DroneStateMachine


func _ready():
	add_state("idle")
	add_state("patrol")
	add_state("fire")
	add_state("initializing")
	call_deferred('set_state', states.idle)
	._ready()

func _state_logic(delta):	
	._state_logic(delta)
	
func _get_transition(delta):
	match state:
		states.idle:
			if looking_for_player:
				return states.patrol
		states.patrol: 
			if parent.cooldown.is_stopped():
				return states.fire
			else:
				if !looking_for_player:
					return states.idle
		states.fire:
			if !parent.cooldown.is_stopped():
				if !looking_for_player:
					return states.idle
				else:
					return states.patrol
						
				
				
		
	return null
	
func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.playback.travel("idle")
		states.patrol:
			#Play patrol anim and then start patrol
			parent.playback.travel("move")
		states.fire:
			parent.playback.travel("move")
			parent._fire(ray_direction)
			parent.cooldown.start()
#func _exit_state(old_state, new_state):
#	match old_state:
#		states.fire:
#			print("Stopped Firing")
			
	
