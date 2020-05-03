extends Node2D

onready var A = $Keys/left
onready var D = $Keys/right2
onready var W = $"WallJump Instruction/up"
onready var space = $Keys/space
onready var space2 = $Keys/space2

func _hold_key(key):
	key.frame += 1
	
func _release_key(key):
	key.frame -= 1

func _physics_process(delta):
	
	#Pressing key
	if Input.is_action_just_pressed("WASD_up"):
		_hold_key(W)
	if Input.is_action_just_pressed('WASD_left'):
		_hold_key(A)
	if Input.is_action_just_pressed('WASD_right'):
		_hold_key(D)
	if Input.is_action_just_pressed("special"):
		_hold_key(space)
		_hold_key(space2)
	
	#Releasing key
	if Input.is_action_just_released('WASD_up'):
		_release_key(W)
	if Input.is_action_just_released('WASD_left'):
		_release_key(A)
	if Input.is_action_just_released('WASD_right'):
		_release_key(D)
	if Input.is_action_just_released("special"):
		_release_key(space)
		_release_key(space2)
