extends Node2D

onready var tween = $Tween as Tween

func _ready():
	pass


func dissapear_platform(front, back):
	tween.interpolate_property(front, "modulate:a", 1, 0, 1, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.interpolate_property(back, "modulate:a", 1, 0, 1, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.start()
	yield(get_tree().create_timer(1), "timeout")
	front.set_collision_layer_bit(2, false)
	yield(get_tree().create_timer(0.5), "timeout")
	appear_platform(front, back)
		


func appear_platform(front, back):
	tween.interpolate_property(front, "modulate:a", 0, 1, 1, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.interpolate_property(back, "modulate:a", 0, 1, 1, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.start()
	front.set_collision_layer_bit(2, true)


func change_platform_layer(platform, layer):
	var current_color = platform.modulate
	var new_color
	var old_layer
	match layer:
		0:
			new_color = Color(0, 0.972549, 1)
			old_layer = 2
		1:
			new_color = Color(1, 0.529412, 0)
			old_layer = 0
		2:
			new_color = Color(0.85098, 0, 1)
			old_layer = 1
	tween.interpolate_property(platform, "modulate", current_color, new_color, 1, tween.TRANS_LINEAR)
	tween.start()
	platform.set_collision_layer_bit(layer, true)
	yield(get_tree().create_timer(1), "timeout")
	platform.set_collision_layer_bit(old_layer, false)
	

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		print('TAB')
		change_platform_layer($Tiles/Platform1/Front, 1)


