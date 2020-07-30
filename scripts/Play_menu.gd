extends Control




func _on_NewGame_pressed():
	Save.delete_saves()
	get_tree().change_scene("res://scenes/menus/TutorialMenu.tscn")


func _on_NewGame_button_down():
	$CanvasLayer/Panel/NewGame/Sprite.frame = 2


func _on_NewGame_mouse_entered():
	$CanvasLayer/Panel/NewGame/Sprite.frame = 1


func _on_NewGame_mouse_exited():
	$CanvasLayer/Panel/NewGame/Sprite.frame = 0


func _on_LoadGame_button_down():
	$CanvasLayer/Panel/LoadGame/Sprite.frame = 2


func _on_LoadGame_pressed():
	get_tree().change_scene("res://scenes/menus/Load_menu.tscn")


func _on_LoadGame_mouse_entered():
	$CanvasLayer/Panel/LoadGame/Sprite.frame = 1


func _on_LoadGame_mouse_exited():
	$CanvasLayer/Panel/LoadGame/Sprite.frame = 0




func _on_Back_pressed():
	get_tree().change_scene("res://scenes/menus/Main_menu.tscn")


func _on_Back_mouse_exited():
	$CanvasLayer/Panel/Back/Sprite.frame = 0


func _on_Back_mouse_entered():
	$CanvasLayer/Panel/Back/Sprite.frame = 1


func _on_Back_button_down():
	$CanvasLayer/Panel/Back/Sprite.frame = 2
