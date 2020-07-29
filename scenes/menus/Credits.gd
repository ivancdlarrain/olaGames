extends Node2D

onready var tween = get_node("Tween") as Tween

func appear():
	tween.interpolate_property($"CanvasLayer/VBoxContainer", "modulate.a", 0, 255, 1.0)


func dissapear():
	tween.interpolate_property($"CanvasLayer/VBoxContainer", "modulate.a", 255, 0, 1.0)


func _ready():
	$AnimationPlayer.play("creditsroll")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
