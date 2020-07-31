extends AudioStreamPlayer2D


var change_to_blue_sfx = load("res://assets/SFX/Boss a azul.wav")
var change_to_orange_sfx = load("res://assets/SFX/Boss a Naranjo.wav")
var change_to_purple_sfx = load("res://assets/SFX/Boss a morado.wav")


func _ready():
	pass # Replace with function body.

func play_change_to_blue():
	self.stream = change_to_blue_sfx
	self.play()
func play_change_to_purple():
	self.stream = change_to_purple_sfx
	self.play()
func play_change_to_orange():
	self.stream = change_to_orange_sfx
	self.play()
