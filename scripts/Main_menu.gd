extends Control

func _ready():
	pass

func _on_NewGame_pressed():
	get_tree().change_scene("res://scenes/Tutorials/Tutorial 1.tscn")


func _on_NewGame2_pressed():
	get_tree().quit()


func _on_Load_Game_pressed():
	Save.load_game()
