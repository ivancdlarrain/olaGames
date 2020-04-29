extends Node2D

func _ready():
	pass

func _process(_delta):
	# Respawn
	if $KinematicBody2D.get_position().y > 1000:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
