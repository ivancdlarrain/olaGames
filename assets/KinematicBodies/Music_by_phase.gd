extends AudioStreamPlayer

var blue_loop = load("res://assets/OST/Fase Azul.wav")
var orange_loop = load("res://assets/OST/Fase Naranjo.wav")
var purple_loop = load("res://assets/OST/Fase Morado.wav")


func _ready():
	pass # Replace with function body.

func play_blue_loop():
	self.stream = blue_loop
	self.play()
func play_purple_loop():
	self.stream = purple_loop
	self.play()
func play_orange_loop():
	self.stream = orange_loop
	self.play()
