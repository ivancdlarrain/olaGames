extends Node2D

onready var W = $Wkey
onready var A = $Akey
onready var S = $Skey
onready var D = $Dkey
onready var blue = $blue
onready var orange = $orange
onready var purple = $purple
onready var space = $space


func _hold_key(key):
	key.frame += 1
	
func _release_key(key):
	key.frame -= 1
	
func _physics_process(delta):
	# Holding keys
	if Input.is_action_just_pressed("WASD_up"):
		_hold_key(W)
	if Input.is_action_just_pressed('WASD_left'):
		_hold_key(A)
	if Input.is_action_just_pressed('WASD_down'):
		_hold_key(S)
	if Input.is_action_just_pressed('WASD_right'):
		_hold_key(D)
	if Input.is_action_just_pressed('ui_left'):
		_hold_key(blue)
	if Input.is_action_just_pressed('ui_down'):
		_hold_key(orange)
	if Input.is_action_just_pressed('ui_right'):
		_hold_key(purple)
	if Input.is_action_just_pressed('special'):
		_hold_key(space)
		
	# Releasing keys
	if Input.is_action_just_released('WASD_up'):
		_release_key(W)
	if Input.is_action_just_released('WASD_left'):
		_release_key(A)
	if Input.is_action_just_released('WASD_down'):
		_release_key(S)
	if Input.is_action_just_released('WASD_right'):
		_release_key(D)
	if Input.is_action_just_released('ui_left'):
		_release_key(blue)
	if Input.is_action_just_released('ui_down'):
		_release_key(orange)
	if Input.is_action_just_released('ui_right'):
		_release_key(purple)
	if Input.is_action_just_released('special'):
		_release_key(space)
