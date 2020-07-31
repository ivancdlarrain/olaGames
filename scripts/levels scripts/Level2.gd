extends Node2D

onready var box_dialogue = $HUDcanvas/DialogueBox

func _ready():
	yield(get_tree().create_timer(.001), "timeout")
	get_node('Player').get_node("ColorState").set_state(1)
	get_node('Player').get_node('Sprite').modulate = Color(1, 0.529412, 0)
	get_node('Player').get_node("Light2D").color = Color(1, 0.529412, 0)
	get_node('Player').get_node("ColorState").set_physics_process(false)
	if !Respawnstate.respawned:
		box_dialogue.start()

func _process(_delta):
	# Respawn
	if $Player.get_position().y > 500:
		$Player._die()



func _on_DialogueBox_dialogue_start():
	$HUDcanvas/HUD.visible = false
	$"Player/MovementState".set_physics_process(false)
	$"Player/ColorState".set_physics_process(false)


func _on_DialogueBox_dialogue_end():
#	$HUDcanvas/HUD.visible = true
	$"Player/MovementState".set_physics_process(true)
#	$"Player/ColorState".set_physics_process(true)
