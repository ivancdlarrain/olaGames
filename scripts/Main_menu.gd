extends Control

var anim_played = "title2"

func _ready():
	$TitleTimer.start()
	if MusicController.stream != MusicController.menu_music:
		MusicController.play_menu_music()
	


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
	$Sfx.play_over_button_sfx()


func _on_TextureButton_mouse_exited():
	$CanvasLayer/Panel/PlayButton/Play.frame = 0


func _on_TextureButton_pressed():
	get_tree().quit()


func _on_QuitButton_mouse_entered():
	$CanvasLayer/Panel/QuitButton/Quit.frame = 1
	$Sfx.play_over_button_sfx()


func _on_QuitButton_mouse_exited():
	$CanvasLayer/Panel/QuitButton/Quit.frame = 0


func _on_PlayButton_button_down():
	$CanvasLayer/Panel/PlayButton/Play.frame = 2
	$Sfx.play_click_sfx()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/menus/Play_menu.tscn")


func _on_QuitButton_button_down():
	$CanvasLayer/Panel/QuitButton/Quit.frame = 2
	$Sfx.play_click_sfx()


func _on_Credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")
