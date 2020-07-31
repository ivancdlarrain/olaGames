extends AudioStreamPlayer


var sfx = load("res://assets/SFX/Portal.wav")

func _ready():
	pass # Replace with function body.

func play_sfx():
	self.stream = sfx
	self.play()

