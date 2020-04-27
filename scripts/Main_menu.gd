extends Control

func _ready():
	pass

func _on_NewGame_pressed():
	get_tree().change_scene("res://scenes/Test_level.tscn")


func _on_NewGame2_pressed():
	get_tree().quit()
