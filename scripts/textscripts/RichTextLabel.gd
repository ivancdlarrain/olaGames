extends RichTextLabel

func _ready():
	modulate.a = 0
	

func _on_Area2D_body_entered(body):
	print("entered")
	modulate.a = 255
