extends Node

class_name DialoguePlayer

signal finished

var title = ""
var text = ""

var conversation: Array
var index = 0

func start(dialogue):
	conversation = dialogue.values()
	index = 0
	update()

func next():
	index += 1
	assert (index <= conversation.size())
	update()

func update():
	text = conversation[index].text
	title = conversation[index].name
	if index == conversation.size() - 1:
		emit_signal("finished")
	


