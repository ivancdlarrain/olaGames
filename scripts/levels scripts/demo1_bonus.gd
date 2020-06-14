extends Node2D

func _ready():
	yield(get_tree().create_timer(.001), "timeout")
	$Player.get_node("ColorState").set_physics_process(false)

func _process(_delta):
	# Respawn
	if $Player.get_position().y > 1000:
		$Player._die()
