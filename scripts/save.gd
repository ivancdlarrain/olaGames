extends Node

const SAVE_PATH = "res://data/savegames/savegame.json"
var _settings = {}

func _ready():
	load_game()

func save_game():
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("saveable")
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
		pass
	
	var savefile = File.new()
	savefile.open(SAVE_PATH, File.WRITE)
	
	savefile.store_line(to_json(save_dict))
	savefile.close()

func load_game():
	#Load Game
	pass
	
	

