extends Node

const SAVE1 = "res://data/savegames/savegame1.json"
const SAVE2 = "res://data/savegames/savegame2.json"
const SAVE3 = "res://data/savegames/savegame3.json"

const SAVE_ORDER = "res://data/savegames/saveorder.cfg"
var cfg_file = ConfigFile.new()


var save_slots = [SAVE1, SAVE2, SAVE3]
var order_cfg = {"order" : []}



func _ready():
	pass

func save_game():
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("saveable")
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
		pass
	
	var savefile = File.new()
	savefile.open(save_slots[0], File.READ)
	
	savefile.store_line(to_json(save_dict))
	savefile.close()
	push_order()

func load_game(slot):
	print("Loading Game")
	var savefile = File.new()
	if not savefile.file_exists(save_slots[slot]):
		return
	
	savefile.open(save_slots[slot], File.READ)
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

func generate_order_cfg():
	for order in save_slots:
		order_cfg["order"].append(order[4])
	cfg_file.set_value(order_cfg)
	cfg_file.save(SAVE_ORDER)
				
	
	

func load_order():
	var error = cfg_file.load(SAVE_ORDER)
	if error != OK:
		print ("Error loading the settings. Error code %s" % error)
		return []
	for slot in cfg_file["order"]:
		match slot:
			1: save_slots[slot] = SAVE1
			2: save_slots[slot] = SAVE2
			3: save_slots[slot] = SAVE3
	return	

func push_order():
	var last = save_slots[2]
	save_slots[2] = save_slots[1]
	save_slots[1] = save_slots[0]
	save_slots[0] = last
		

	
	
	
	
	
	

