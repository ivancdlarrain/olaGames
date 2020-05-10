extends Node2D

onready var lkey = $left
onready var dkey = $down
onready var rkey = $right

func _hold_key(key):
	key.frame = 1
	
func _release_key(key):
	key.frame = 0

func _physics_process(delta):
	#Pressing key
	if Input.is_action_just_pressed("ui_left"):
		_hold_key(lkey)
	if Input.is_action_just_pressed("ui_down"):
		_hold_key(dkey)
	if Input.is_action_just_pressed("ui_right"):
		_hold_key(rkey)
	
	#Releasing key
	if Input.is_action_just_released("ui_left"):
		_release_key(lkey)
	if Input.is_action_just_released("ui_down"):
		_release_key(dkey)	
	if Input.is_action_just_released("ui_right"):
		_release_key(rkey)	
