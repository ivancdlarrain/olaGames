extends Node2D

func _ready():
	pass

func _process(_delta):
	# Respawn
	if $Player.get_position().y > 1000:
		$Player._die()
