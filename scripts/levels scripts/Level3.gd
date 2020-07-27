extends Node2D


func _ready():
	yield(get_tree().create_timer(.001), "timeout")
	get_node('Player').get_node("ColorState").set_state(2)
	get_node('Player').get_node('Sprite').modulate = Color(0.85098, 0, 1)
	get_node('Player').get_node("Light2D").color = Color(0.85098, 0, 1)


