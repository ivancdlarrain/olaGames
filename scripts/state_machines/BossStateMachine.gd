extends DroneStateMachine

onready var color = get_parent().get_node("ColorState")

func _ready():
	._ready()
	add_state('idle')
	add_state('chase')
	add_state('casting_attack')
	add_state('attack')
	call_deferred('set_state', states.idle)


func _state_logic(delta):
	._state_logic(delta)
	match state:
		states.idle:
			parent.apply_deaccel()
		
		states.chase:
			parent.horizontal_movement(ray_direction.x > 0)
		
		states.casting_attack:
			pass
		
		states.attack:
			parent.move_and_slide(parent.velocity)


func _get_transition(delta):
	match state:
		states.idle:
			pass
		
		states.chase:
			pass
		
		states.casting_attack:
			pass
		
		states.attack:
			pass
		
	return null


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
		
		states.chase:
			pass
		
		states.casting_attack:
			pass
		
		states.attack:
			parent.attack()


func _exit_state(old_state, new_state):
	match old_state:
		states.idle:
			pass
		
		states.chase:
			pass
		
		states.casting_attack:
			pass
		
		states.attack:
			pass

