extends StateMachine


var color_switch = 0


onready var sprite = parent.get_node('Sprite') as Sprite
onready var guts = parent.get_node('Guts') as Area2D
onready var light = parent.get_node('Light2D') as Light2D


func change_color(new_color):
	sprite.modulate = new_color
	light.color = new_color


func enter_layer(layer):
	parent.set_collision_layer_bit(layer, true)
	parent.set_collision_mask_bit(layer, true)
	guts.set_collision_layer_bit(layer, true)
	guts.set_collision_mask_bit(layer, true)


func exit_layer(layer):
	parent.set_collision_layer_bit(layer, false)
	parent.set_collision_mask_bit(layer, false)
	guts.set_collision_layer_bit(layer, false)
	guts.set_collision_mask_bit(layer, false)


func _ready():
	light.set_light_mask(2)
	add_state('blue')
	add_state('orange')
	add_state('purple')
	call_deferred('set_state', states.blue)


func _state_logic(_delta):
	if Input.is_action_just_pressed("ui_left") and state != 0:
		color_switch = 0
	elif Input.is_action_just_pressed("ui_down") and state != 1:
		color_switch = 1
	elif Input.is_action_just_pressed("ui_right") and state != 2:
		color_switch = 2
	else:
		color_switch = -1


func _get_transition(_delta):
	match color_switch:
		0:
			return states.blue
		1:
			return states.orange
		2:
			return states.purple
	return null


func _enter_state(new_state, _old_state):
	match new_state:
		states.blue:
			change_color(Color(0, 0.972549, 1))
			enter_layer(0)
		states.orange:
			change_color(Color(1, 0.529412, 0))
			enter_layer(1)
		states.purple:
			change_color(Color(0.85098, 0, 1))
			enter_layer(2)
			parent.grav = parent.purple_grav


func _exit_state(old_state, _new_state):
	match old_state:
		states.blue:
			exit_layer(0)
		states.orange:
			exit_layer(1)
		states.purple:
			exit_layer(2)
			parent.grav = parent.default_grav
