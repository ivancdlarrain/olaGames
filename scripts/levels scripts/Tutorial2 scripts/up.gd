extends Sprite


var done = false

func _ready():
	modulate.a = 0





func _on_Area2D_body_entered(body):
	if !done:
		$Tween2.interpolate_property(self, "modulate:a", 0, 255, 2.0, Tween.TRANS_SINE, Tween.EASE_IN)
		$Tween2.start()
		done = true
