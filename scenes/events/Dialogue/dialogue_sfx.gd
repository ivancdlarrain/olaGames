extends AudioStreamPlayer



var dialogue_sfx = load("res://assets/SFX/Dialogo.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_dialogue_sfx():
	self.stream = dialogue_sfx
	self.play()

