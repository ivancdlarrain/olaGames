extends Node2D

onready var tween = $Tween as Tween

func _ready():
	yield(get_tree().create_timer(0.001), "timeout")
	get_node('Player').get_node("ColorState").set_state(1)
	get_node('Player').get_node('Sprite').modulate = Color(1, 0.529412, 0)
	get_node('Player').get_node("Light2D").color = Color(1, 0.529412, 0)


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


func change_background_color(layer):
	var background = $Player/ParallaxBackground/ParallaxLayer/Sprite
	var current_color = background.modulate
	var colors = [Color(0, 0.972549, 1), Color(1, 0.529412, 0), Color(0.85098, 0, 1)]
	tween.interpolate_property(background, "modulate", current_color, colors[layer], 1, tween.TRANS_LINEAR)


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		print('TAB')
		$Enemies/Boss.fire()
	
	




func _on_Boss_take_damage():
	$HealthBar.interpolate_property($HUDcanvas/ProgressBar, "value", $HUDcanvas/ProgressBar.value, $Enemies/Boss.health, 1, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$HealthBar.start()
