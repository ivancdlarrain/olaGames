extends Node
class_name DialogueAction

export (String, FILE, "*.json")var dialogue_path: String

func interact() -> void:
	var dialogue = load_dialogue()
	owner.play_dialogue(dialogue)

func load_dialogue() -> Dictionary:
	var file = File.new()
	assert(file.file_exists(dialogue_path))
	
	file.open(dialogue_path, file.READ)
	var dialogue = JSON.parse(file.get_as_text()).result
	assert(dialogue.size() > 0)
	return dialogue 
	
