extends Sprite
class_name Key


func _ready():
	frame = 0
	set_light_mask(0)    # Keys will not be affected by light :)


func hold_key():
	frame = 1


func release_key():
	frame = 0
