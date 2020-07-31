extends AudioStreamPlayer


var click_sfx = load("res://assets/SFX/Click boton.wav")
var over_button_sfx = load("res://assets/SFX/Over Button.wav")
func _ready():
	pass # Replace with function body.

func play_click_sfx():
	self.stream = click_sfx
	self.play()
func play_over_button_sfx():
	self.stream = over_button_sfx
	self.play()
