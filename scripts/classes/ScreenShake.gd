extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

#This is a modular screen shake node that allows the camera to shake when called.
#IMPORTANT: Must always be the children of a Camera node
#Properties:
#shakeAmplitude : the maximum amplitude of the shake, given as a parameter when calling the node from another scene

var shakeAmplitude = 0

onready var camera = get_parent()

#Main function for calling a shake. Receives:
#Duration (in seconds), default value 0.2 seconds
#Frequency (in shakes per second), default value = 15 shakes/sec
#Amplitude (in pixels), needs to be half of the desired amplitude, because the 
#shake vector is generated using (-amplitude, amplitude) 

func _start(duration = 0.2, frequency = 15, amplitude = 16):
	self.shakeAmplitude = amplitude
	$Duration.wait_time = duration
	$Frequency.wait_time = 1 / float(frequency)
	
	$Duration.start()
	$Frequency.start()
	
	_new_shake()

#Shakes the camera randomly between the shakeAmplitude values
func _new_shake():
	var rand = Vector2() 
	rand.x = rand_range(-shakeAmplitude, shakeAmplitude)
	rand.y = rand_range(-shakeAmplitude, shakeAmplitude)
	
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

#Puts the camera offset back to (0,0)
func _reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, Vector2() , $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func _on_Frequency_timeout():
	_new_shake()


func _on_Duration_timeout():
	_reset()
	$Frequency.stop()
