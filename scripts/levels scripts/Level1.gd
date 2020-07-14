extends Node2D

onready var action_dialogue = $Dialogue
onready var box_dialogue = $Dialogue/DialogueBox

func _ready():
	action_dialogue.interact()
	
func play_dialogue(dialogue):
	box_dialogue.start(dialogue)

	
