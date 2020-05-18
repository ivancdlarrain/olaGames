extends Sprite
class_name Key


func _ready():
	frame = 0


func hold_key():
	frame = 1


func release_key():
	frame = 0
