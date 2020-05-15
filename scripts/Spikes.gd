extends TileMap


var tween_values = [1.0, 0.5]


func _ready():
# warning-ignore:return_value_discarded
	$Tween.connect("tween_all_completed", self, "on_tween_all_completed")
	on_tween_all_completed()
	
func on_tween_all_completed():
	$Tween.interpolate_property(self, "modulate:v", tween_values[0], tween_values[1], 1.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	tween_values.invert()


func modulate_value(value: float):
	modulate.v = value
