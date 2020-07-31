extends StateMachine

var changing_color = false


func _ready():
	add_state("blue")
	add_state("orange")
	add_state("purple")
	call_deferred('set_state', states.orange)


#func enter_layer(layer):
#	parent.set_collision_layer_bit(layer, true)
#	parent.set_collision_mask_bit(layer, true)
#
#
#func exit_layer(layer):
#	parent.set_collision_layer_bit(layer, false)
#	parent.set_collision_mask_bit(layer, false)


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
#	enter_layer(new_state)
	for platform in parent.platforms:
		parent.level.change_platform_layer(platform, new_state)
	var sfx = get_parent().get_node("Sfx")
	var color_loop = get_parent().get_node("Music_loop")
	match new_state:
		states.blue:
			color_loop.play_blue_loop()
			sfx.play_change_to_blue()
		states.orange:
			color_loop.play_orange_loop()
			sfx.play_change_to_orange()
		states.purple:
			color_loop.play_purple_loop()
			sfx.play_change_to_purple()
			
		


func _exit_state(old_state, _new_state):
#	exit_layer(old_state)
	pass

