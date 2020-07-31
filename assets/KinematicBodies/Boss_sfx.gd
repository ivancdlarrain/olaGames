extends AudioStreamPlayer2D


var change_to_blue_sfx = load("res://assets/SFX/Boss a azul.wav")
var change_to_orange_sfx = load("res://assets/SFX/Boss a Naranjo.wav")
var change_to_purple_sfx = load("res://assets/SFX/Boss a morado.wav")
var explosion_sfx = load("res://assets/SFX/Explosion.wav")
var shoot_sfx = load("res://assets/SFX/Disparo Azul.wav")


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
func play_explosion():
	self.stream = explosion_sfx
	self.play()
func play_shoot_sfx():
	self.stream = shoot_sfx
	self.play()
