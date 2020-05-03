extends RichTextLabel

func _ready():
	pass
	

func _on_Area2D_body_entered(body):
	print("entered")
	$Tween.interpolate_property(self, "modulate:a", 0 , 255, 2.0, Tween.TRANS_SINE, Tween.EASE_IN)
	print(modulate.a)
