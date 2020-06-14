extends Node2D

func _ready():
	yield(get_tree().create_timer(.001), "timeout")
	get_node('Player').get_node("ColorState").set_state(1)
	get_node('Player').get_node('Sprite').modulate = Color(1, 0.529412, 0)
	get_node('Player').get_node("Light2D").color = Color(1, 0.529412, 0)
	$Player.get_node("ColorState").set_physics_process(false)

func _process(_delta):
	# Respawn
	if $Player.get_position().y > 1000:
		$Player._die()
