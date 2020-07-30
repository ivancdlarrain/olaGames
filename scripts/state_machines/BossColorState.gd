extends StateMachine

var changing_color = false

func _ready():
	add_state("blue")
	add_state("orange")
	add_state("purple")
	call_deferred('set_state', states.orange)


func enter_layer(layer):
	parent.set_collision_layer_bit(layer, true)
	parent.set_collision_mask_bit(layer, true)


func exit_layer(layer):
	parent.set_collision_layer_bit(layer, false)
	parent.set_collision_mask_bit(layer, false)


func _get_transition(_delta):
	if changing_color:
		match state:
			states.blue:
				return states.orange
		
			states.orange:
				return states.purple
		
			states.purple:
				return states.blue
	
	return null


func _enter_state(new_state, _old_state):
	changing_color = false
	enter_layer(new_state)
	var level = get_tree().get_root().get_node("BossFight")
	for platform in level.platforms:
		level.change_platform_layer(platform, new_state)


func _exit_state(old_state, _new_state):
	exit_layer(old_state)

