extends Drone

# For animation:
onready var animation_player = parent.get_node("AnimationPlayer") as AnimationPlayer

func _ready():
	add_state('idle')
	add_state('agro')
	add_state('jump')
	call_deferred('set_state', states.idle)
	._ready()


func _state_logic(delta):
	parent._apply_friction()
	parent._apply_gravity(delta)
	parent._apply_movement()
	._state_logic(delta)


func _get_transition(delta):
	match state:
		states.idle:
			if found:
				return states.agro
		states.agro:
			if !found:
				return states.idle
		states.jump:
			pass
	return null


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.agro:
			animation_player.play("charge")
		states.jump:
			pass


func _exit_state(old_state, new_state):
	match old_state:
		states.idle:
			pass
		states.agro:
			pass
		states.jump:
			pass


