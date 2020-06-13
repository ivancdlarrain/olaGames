extends StaticBody2D


func _ready():
	$"effect zone".set_collision_layer(get_collision_layer())
	$"effect zone".set_collision_mask(get_collision_mask())

func _on_effect_zone_body_entered(body):
	if body in get_tree().get_nodes_in_group("alive"):
		$AnimationPlayer.play('starting')

func _on_AnimationPlayer_animation_finished(_anim_name):
	for i in $"effect zone".get_overlapping_bodies():
		if i in get_tree().get_nodes_in_group("alive"):
			i.velocity = Vector2(0, -1000).rotated(rotation_degrees)
			
