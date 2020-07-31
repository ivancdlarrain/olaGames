extends Node2D
onready var box_dialogue = $HUDcanvas/DialogueBox
onready var cutscene_dialogue = $HUDcanvas/CutsceneDialogue
var on_cutscene = false
var cutscene_triggered = false

func _ready():
	yield(get_tree().create_timer(.001), "timeout")
	get_node('Player').get_node("ColorState").set_state(2)
	get_node('Player').get_node('Sprite').modulate = Color(0.85098, 0, 1)
	get_node('Player').get_node("Light2D").color = Color(0.85098, 0, 1)
	get_node('Player').get_node("ColorState").set_physics_process(false)
	box_dialogue.start()
	


	
	

func _process(_delta):
	
	# Cutscene logic:
	if on_cutscene:
		$Player/Camera2D.limit_right = 5000
		if $Player.get_position().y > -1000:
			$"Player/MovementState".set_physics_process(false)
		
		

	# Respawn
	if $Player.get_position().y > 500:
		$Player._die()

func _on_DialogueBox_dialogue_start():
	$HUDcanvas/HUD.visible = false
	$"Player/MovementState".set_physics_process(false)
	$"Player/ColorState".set_physics_process(false)



func _on_DialogueBox_dialogue_end():
#	$HUDcanvas/HUD.visible = true
	$"Player/MovementState".set_physics_process(true)
#	$"Player/ColorState".set_physics_process(true)


func _on_TriggerArea_area_entered(area):
	if cutscene_dialogue:
		cutscene_dialogue.start()


func _on_Area2D_area_entered(area):
	if !cutscene_triggered:
		cutscene_triggered = true
		$AudioStreamPlayer.play_cutscene_music()
		$Cutscene/CutsceneCamera.position = $Player/Camera2D.position + $Player.get_position()
		$Cutscene/CutsceneCamera.current = true
		print($Player.get_position())
		$Cutscene/AnimationPlayer.play("cutscene")
		on_cutscene = true
	


func _on_AnimationPlayer_animation_finished(anim_name):
	on_cutscene = false
	$"Player/MovementState".set_physics_process(true)
	get_tree().change_scene("res://scenes/demo1.tscn")


func _on_Cutscene_dialogue_start():
	$HUDcanvas/HUD.visible = false
	$Player.playback.travel("idle")
	$"Player/MovementState".set_physics_process(false)
	$"Player/ColorState".set_physics_process(false)


func _on_Cutscene_dialogue_end():
	#	$HUDcanvas/HUD.visible = true
	$"Player/MovementState".set_physics_process(true)
	$Player/AnimationTree.active = true
	
#	$"Player/ColorState".set_physics_process(true)
