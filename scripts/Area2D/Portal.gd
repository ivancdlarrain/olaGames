extends Area2D

export(String, FILE, '*.tscn') var world_scene

func _ready():
	$AnimationPlayer.play('default')
	
func _on_Portal_body_entered(_body):
# warning-ignore:return_value_discarded
	Respawnstate.respawned = false
	get_tree().change_scene(world_scene)
