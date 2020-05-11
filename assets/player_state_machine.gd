extends "res://state_machine/state_machine.gd"


func _ready():
	states_map = {
		"Run" : $Run,
		"Idle" : $Idle
	}

func _change_state(state_name):
	
	if state_name in ["jump"]:
		states_stack.push_front(states_map[state_name])
	if state_name == "jump" and current_state == $Move:
		$Jump.initialize($Move.speed, $Move.velocity)
	._change_state(state_name)


	
		
