extends AudioStreamPlayer


var menu_music = load("res://assets/OST/Menu Chameneon.ogg")
var level_music = load("res://assets/OST/Fabrica Chameneon.ogg")
func _ready():
	pass # Replace with function body.

func play_menu_music():
	self.stream = menu_music
	self.play()
func play_level_music():
	self.stream = level_music
	self.play()