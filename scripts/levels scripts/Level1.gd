extends Node2D

onready var box_dialogue = $HUDcanvas/DialogueBox

func _ready():
	box_dialogue.start()
	

	


func _on_DialogueBox_dialogue_start():
	$HUDcanvas/HUD.visible = false
	$Player.set_physics_process(false)



func _on_DialogueBox_dialogue_end():
	$HUDcanvas/HUD.visible = true
	$Player.set_physics_process(true)
