extends Node2D

onready var box_dialogue = $HUDcanvas/DialogueBox

func _ready():
	
	get_node('Player').get_node("ColorState").set_physics_process(false)
	
	if !Respawnstate.respawned:
		box_dialogue.start()


func _physics_process(_delta):
	if $Player.get_position().y > 1000:
		get_tree().reload_current_scene()


func _on_DialogueBox_dialogue_start():
	$HUDcanvas/HUD.visible = false
	$"Player/MovementState".set_physics_process(false)
	$"Player/ColorState".set_physics_process(false)



func _on_DialogueBox_dialogue_end():
#	$HUDcanvas/HUD.visible = true
	$"Player/MovementState".set_physics_process(true)
#	$"Player/ColorState".set_physics_process(true)
