extends Control




func _on_Slot_1_pressed():
	Save.load_game(0)


func _on_Slot_2_pressed():
	Save.load_game(1)


func _on_Slot_3_pressed():
	Save.load_game(2)


func _on_Back_pressed():
	get_tree().change_scene("res://scenes/menus/Play_menu.tscn")
