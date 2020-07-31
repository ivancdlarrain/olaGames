extends AudioStreamPlayer


var level_music = load("res://assets/OST/Nivel 3 (loop en 14.608s).ogg")
var cutscene_music = load("res://assets/OST/Nivel 4.ogg")
func _ready():
	pass # Replace with function body.


func play_cutscene_music():
	self.stream = cutscene_music
	self.play()
