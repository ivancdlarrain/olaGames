extends Node2D

onready var box_dialogue = $HUDcanvas/DialogueBox
var dialogue = {
	"0": { "name":"Player", "text": "That was a strange dream..."},
	"1": { "name":"Mysterious voice", "text": "Hear me, my child"},
	"2": { "name":"Player", "text": "What? Where is that voice coming from?"},
	"3": { "name": "Mysterious voice", "text": "Do not fear, I want to help you. Step into the portal in front of you"}
}

func _ready():
	box_dialogue.dialogue_dict = dialogue
	get_node('Player').get_node("ColorState").set_physics_process(false)
	
	if !Respawnstate.respawned:
		box_dialogue.start()



func _physics_process(_delta):
	if $Player.get_position().y > 1000:
		$Player._die()


func _on_DialogueBox_dialogue_start():
	$HUDcanvas/HUD.visible = false
	$"Player/MovementState".set_physics_process(false)
	$"Player/ColorState".set_physics_process(false)



func _on_DialogueBox_dialogue_end():
#	$HUDcanvas/HUD.visible = true
	$"Player/MovementState".set_physics_process(true)
#	$"Player/ColorState".set_physics_process(true)
