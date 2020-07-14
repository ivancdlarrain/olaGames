extends Node2D

func _ready():
	$HUDcanvas/DialogueBox.visible = false

func _process(_delta):
	# Respawn
	if $Player.get_position().y > 2000:
		$Player._die()


#Hide switch HUD when in dialogue

func _on_DialogueBox_dialogue_start():
	$HUDcanvas/HUD.visible = false
	$Player.set_physics_process(false)



func _on_DialogueBox_dialogue_end():
	$HUDcanvasHUD.visible = true
	$Player.set_physics_process(true)
