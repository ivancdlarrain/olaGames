extends Node
class_name DialogueAction

export var dialogue_path: String

func load_dialogue() -> Dictionary:
	var file = File.new()
	assert(file.file_exists(dialogue_path))
	
	file.open(dialogue_path, file.READ)
	var dialogue = JSON.parse(file.get_as_text())
	assert(dialogue.size > 0)
	return dialogue
	
