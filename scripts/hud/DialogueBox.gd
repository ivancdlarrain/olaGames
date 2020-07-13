extends Control
class_name DialogueBox

signal dialogue_ended()

#Text labels:
onready var text_label = $Panel/MarginContainer/Columns/DialogueText
onready var name_label = $Panel/MarginContainer/Columns/Name

#Buttons:
onready var next_button = $Panel/MarginContainer/Columns/Next
onready var done_button = $Panel/MarginContainer/Columns/Done

#CharPortrait:
onready var portrait = $CharPortrait

func start(dialogue) -> void:
	done_button.hide()
	next_button.show()
	next_button.grab_focus() #Focuses the input into this button
	#dialogue_player.start(dialogue)
	update_content()
	show()

func button_next_pressed() -> void:
	#dialogue_player.next()
	update_content()

func dialogue_player_finished() -> void:
	next_button.hide()
	done_button.show()
	done_button.grab_focus()

func button_finished_pressed() -> void:
	emit_signal("dialogue_ended")
	hide()
	
func update_content():
	#var dialogue_player_name = dialogue_player.title
	var dialogue_player_name = 'Testname'
	name_label.text = dialogue_player_name
	#var dialogue_player_text = dialogue_player.text
	var dialogue_player_text = 'This is a test dialogue'
	text_label.text = dialogue_player_name
	#portrait.texture = DialogueDatabase.get_texture(dialogue_player_name)
	
	


