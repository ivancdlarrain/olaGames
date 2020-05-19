extends Control

func _input(event):
	if event.is_action_pressed('Pause'):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		$CanvasLayer/VBoxContainer.visible = new_pause_state


func _on_Resume_pressed():
	visible = false
	$CanvasLayer/VBoxContainer.visible = false
	get_tree().paused = false


func _on_Main_Menu_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/menus/Main_menu.tscn")

func _on_Save_pressed():
	Save.save_game()
	
	
#------------ Saved Games Menu ------------#

func _on_Load_pressed():
	
	$CanvasLayer/VBoxContainer.visible = false
	$"CanvasLayer/Save Slots".visible = true



func _on_Slot_1_pressed():
	Save.load_game(0)
	get_tree().paused = false


func _on_Slot_2_pressed():
	Save.load_game(1)
	get_tree().paused = false


func _on_Slot_3_pressed():
	Save.load_game(2)
	get_tree().paused = false


func _on_Back_pressed():
	$"CanvasLayer/Save Slots".visible = false
	$CanvasLayer/VBoxContainer.visible = true
