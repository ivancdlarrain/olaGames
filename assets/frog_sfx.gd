extends AudioStreamPlayer2D


var jump_sfx = load("res://assets/SFX/Enemigo Naranjo Salto.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	self.volume_db = 12


func play_jump_sfx():
	self.stream = jump_sfx
	self.play()
