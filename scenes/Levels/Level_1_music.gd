extends AudioStreamPlayer



var song = load("res://assets/OST/Nivel 1.ogg")


func _ready():
	pass
	
func play_song():
	self.stream = song
	self.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
