extends Control

export (String, FILE, "*.json") var dialogue_filepath: String

onready var dialogue_label = $TextBox/MarginContainer/HBoxContainer/Dialogue
onready var name_label = $NameBox/MarginContainer/Name

var dialogue_dict : Dictionary
var index = 0
var finished: bool

func _ready():
	load_file()

func _physics_process(delta):
	if finished: 
		if Input.is_action_just_pressed("ui_accept"):
			display_dialogue()

func load_file():
	var dialogue_file = File.new()
	assert(dialogue_file.file_exists(dialogue_filepath))
	dialogue_file.open(dialogue_filepath, File.READ)
	var dict = JSON.parse(dialogue_file.get_as_text()).result
	assert(dict.keys().size() > 0)
	dialogue_dict = dict
	display_dialogue()

func display_dialogue():
	finished = false
	var conversation = dialogue_dict.values()
	if index < dialogue_dict.size():
		name_label.text = conversation[index].name
		dialogue_label.text = conversation[index].text
		finished = true
	index += 1
	
