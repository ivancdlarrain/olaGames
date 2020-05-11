extends "res://scripts/states/motion/on_ground/on_ground.gd"

func enter():
#	$AnimationTree.playback.travel("idle")
	pass

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_dir = get_input_direction()
	if input_dir:
		emit_signal("finished", "Run")
	
	if !on_floor:
		emit_signal("finished", "Fall")
	
	
	
	
