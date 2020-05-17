extends Control

var anim_played = "title2"

func _ready():
	$TitleTimer.start()


func _on_NewGame_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Tutorials/Tutorial 1.tscn")


func _on_NewGame2_pressed():
	get_tree().quit()


func _on_Load_Game_pressed():

	Save.load_game()


func _on_AnimationPlayer_animation_finished(anim_name):
	$TitleTimer.start()
	anim_played = anim_name


func _on_TitleTimer_timeout():
	match anim_played:
		"title1":
			$AnimationPlayer.play("title2")
		"title2":
			$AnimationPlayer.play("title1")


# Just buttons connections
func _on_TextureButton_mouse_entered():
	$CanvasLayer/Panel/PlayButton/Play.frame = 1


func _on_TextureButton_mouse_exited():
	$CanvasLayer/Panel/PlayButton/Play.frame = 0


func _on_TextureButton_pressed():
	get_tree().quit()


func _on_QuitButton_mouse_entered():
	$CanvasLayer/Panel/QuitButton/Quit.frame = 1


func _on_QuitButton_mouse_exited():
	$CanvasLayer/Panel/QuitButton/Quit.frame = 0


func _on_PlayButton_button_down():
	$CanvasLayer/Panel/PlayButton/Play.frame = 2


func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/menus/Play_menu.tscn")


func _on_QuitButton_button_down():
	$CanvasLayer/Panel/QuitButton/Quit.frame = 2
