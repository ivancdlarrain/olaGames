extends "res://scripts/states/motion/motion.gd"

class_name on_ground



func handle_input(event):
	if event.is_action_pressed("WASD_up"):
		emit_signal("finished", "Jump")
	return .handle_input(event)

