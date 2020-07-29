extends Node2D


func _ready():
	yield(get_tree().create_timer(.001), "timeout")
	get_node('Player').get_node("ColorState").set_state(1)
	get_node('Player').get_node('Sprite').modulate = Color(1, 0.529412, 0)
	get_node('Player').get_node("Light2D").color = Color(1, 0.529412, 0)

func _process(_delta):
	# Respawn
	if $Player.get_position().y > 500:
		$Player._die()
