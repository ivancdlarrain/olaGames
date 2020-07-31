extends AudioStreamPlayer

onready var volume_fade = get_node("Tween")


var menu_music = load("res://assets/OST/Menu Chameneon.ogg")
var level_music = load("res://assets/OST/Fabrica Chameneon.ogg")
func _ready():
	self.bus = "Musica"

func play_menu_music():
	self.stream = menu_music
	self.play()
func play_level_music():
	self.stream = level_music
	self.play()
func stop_music():
	self.stream = null
	self.stop()
	
