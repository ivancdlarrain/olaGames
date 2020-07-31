extends AudioStreamPlayer2D


var jump_sfx = load("res://assets/SFX/Salto.wav")
var purple_jump_sfx = load("res://assets/SFX/Salto Morado.wav")
var double_jump_sfx = load("res://assets/SFX/Segundo Salto (naranjo).wav")
var die_sfx = load("res://assets/SFX/Muerte.wav")
var dash_sfx = load("res://assets/SFX/Dash.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_jump_sfx():
	self.stream = jump_sfx
	self.play()
func play_purple_jump_sfx():
	self.stream = purple_jump_sfx
	self.play()
func play_double_jump_sfx():
	self.stream = double_jump_sfx
	self.play()
func play_die_sfx():
	self.stream = die_sfx
	self.play()
func play_dash_sfx():
	self.stream = dash_sfx
	self.play()
