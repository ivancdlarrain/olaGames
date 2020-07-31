extends AudioStreamPlayer2D


var activate_sfx = load("res://assets/SFX/Activacion dron azul.wav")


func _ready():
	pass # Replace with function body.

func play_activate_sfx():
	self.stream = activate_sfx
	self.play()

