extends Node

const SAVE_PATH = "res://data/savegames/savegame.json"

var save_slots = []


func _ready():
	pass

func save_game():
#	if save_slot_used():
#		pass
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("saveable")
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
		pass
	
	var savefile = File.new()
	savefile.open(SAVE_PATH, File.READ)
	
	savefile.store_line(to_json(save_dict))
	savefile.close()

func load_game():
	print("Loading Game")
	var savefile = File.new()
	if not savefile.file_exists(SAVE_PATH):
		return
	
	savefile.open(SAVE_PATH, File.READ)
	var save_data = {}
	save_data = JSON.parse(savefile.get_as_text()).result
	
	for node_path in save_data.keys():
		for attribute in save_data[node_path]:
			if attribute == "scene_path":
# warning-ignore:return_value_discarded
				get_tree().change_scene(save_data[node_path]["scene_path"])
				
				#LEAVE THIS AS IS, NEEDS FIXING
#			if attribute == "pos":
#				node.set_position(Vector2(save_data[node_path]["pos"]["x"], save_data[node_path]["pos"]["y"]))
			
	savefile.close()
	
func save_slot_used(savefile: File):
	if savefile.file_exists(SAVE_PATH):
		return true
	
	

