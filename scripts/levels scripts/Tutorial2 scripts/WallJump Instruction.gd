extends Node2D


var done = false

func _ready():
	modulate.a = 0
	


func _on_Area2D_body_entered(body):
	if !done:
		$Tween.interpolate_property(self, "modulate:a", 0, 255, 1.0, Tween.TRANS_SINE, Tween.EASE_IN)
		$Tween.start()
		done = true
	
	
