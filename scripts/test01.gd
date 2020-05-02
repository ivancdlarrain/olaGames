extends Node2D

func _ready():
	pass

func _process(_delta):
	# Respawn
	if $KinematicBody2D.get_position().y > 1000:
		$KinematicBody2D._die()
