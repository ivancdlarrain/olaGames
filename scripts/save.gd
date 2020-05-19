extends Node

const SAVE1 = "res://data/savegames/savegame1.json"
const SAVE2 = "res://data/savegames/savegame2.json"
const SAVE3 = "res://data/savegames/savegame3.json"

const SAVE_ORDER = "res://data/savegames/saveorder.json"


var save_slots = [SAVE1, SAVE2, SAVE3]
var order_dict = {"order" : []}




func _ready():
	load_order_cfg()
	pass

func save_game():
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("saveable")
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
		pass
	push_order()
	var savefile = File.new()
	savefile.open(save_slots[0], File.WRITE)
	print(save_slots[0])
	savefile.store_line(to_json(save_dict))
	savefile.close()
	generate_order_cfg()
	load_order_cfg()

func load_game(slot):
	print("Loading Game")
	var savefile = File.new()
	if not savefile.file_exists(save_slots[slot]):
		return
	
	savefile.open(save_slots[slot], File.READ)
	var save_data = {}
	save_data = JSON.parse(savefile.get_as_text()).result
	print ("Save Data: ", save_data)
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
	order_dict["order"].clear()
	for i in range(3):
		order_dict["order"].insert(i, save_slots[i])
	var order_file = File.new()
	
	order_file.open(SAVE_ORDER, File.WRITE)
	
	order_file.store_line(to_json(order_dict))
	order_file.close()
				
	
	

func load_order_cfg():
	var order_file = File.new()
	if not order_file.file_exists(SAVE_ORDER):
		return "No order found"
		
	order_file.open(SAVE_ORDER, File.READ)
	var order_data = {}
	
	order_data = JSON.parse(order_file.get_as_text()).result
	var new_order = []
	for slot in order_data["order"]:
		match slot:
			SAVE1: new_order.append(SAVE1)
			SAVE2: new_order.append(SAVE2)
			SAVE3: new_order.append(SAVE3)

	save_slots = new_order	

func push_order():
	var last = save_slots.pop_back()
	save_slots.push_front(last)


	
	
	
	
	
	

