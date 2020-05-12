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
	var savefile = File.new()
	if not savefile.file_exists(SAVE_PATH):
		return
	
	savefile.open(SAVE_PATH, File.READ)
	var save_data = {}
	save_data = JSON.parse(savefile.get_as_text()).result
	
	for node_path in save_data.keys():
		for attribute in save_data[node_path]:
			if attribute == "scene_path":
				get_tree().change_scene(save_data[node_path]["scene_path"])
				
				#LEAVE THIS AS IS, NEEDS FIXING
#			if attribute == "pos":
#				node.set_position(Vector2(save_data[node_path]["pos"]["x"], save_data[node_path]["pos"]["y"]))
			
	savefile.close()
	pass
	
	
	

