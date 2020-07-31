extends AudioStreamPlayer


var dialogue1_sfx = load("res://assets/SFX/Dialogo 1.wav")
var dialogue2_sfx = load("res://assets/SFX/Dialogo 2.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_dialogue_1():
	self.stream = dialogue1_sfx
	self.play()
func play_dialogue_2():
	self.stream = dialogue2_sfx
	self.play()

