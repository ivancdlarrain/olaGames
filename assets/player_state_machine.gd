extends "res://state_machine/state_machine.gd"


func _ready():
	states_map = {
		"Run" : $Run,
		"Idle" : $Idle,
		"Jump" : $Jump,
		"Fall" : $Fall
	}

func _change_state(state_name):
	
	if state_name in ["Jump"]:
		states_stack.push_front(states_map[state_name])
	if state_name == "Jump" and current_state == $Run:
		$Jump.initialize($Run.velocity)
	._change_state(state_name)


	
		
