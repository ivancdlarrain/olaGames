extends Area2D


func _ready():
	pass


func _on_AnimatedSprite_animation_finished():
	queue_free()


func _on_RegularExplosion_body_entered(body):
	if body in get_tree().get_nodes_in_group("alive"):
		body.take_damage()
