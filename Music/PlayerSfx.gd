extends AudioStreamPlayer2D


var jump_sfx = load("res://assets/SFX/Salto.wav")
var dash_sfx = load("res://assets/SFX/Dash.wav")
var purple_jump_sfx = load("res://assets/SFX/Salto Morado.wav")
var double_jump_sfx = load("res://assets/SFX/Segundo Salto (naranjo).wav")
var take_damage_sfx = load("res://assets/SFX/Muerte.wav")
func _ready():
	pass # Replace with function body.

func play_jump_sfx():
	self.stream = jump_sfx
	self.play()
func play_dash_sfx():
	self.stream = dash_sfx
	self.play()
func play_purple_jump_sfx():
	self.stream = purple_jump_sfx
	self.play()
func play_double_jump_sfx():
	self.stream = double_jump_sfx
	self.play()
func play_take_damage_sfx():
	self.stream = take_damage_sfx
	self.play()
