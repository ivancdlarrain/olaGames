extends StaticBody2D




func _on_effect_zone_body_entered(_body):
	$AnimationPlayer.play('starting')

func _on_AnimationPlayer_animation_finished(anim_name):
	for i in $"effect zone".get_overlapping_bodies():
		i.velocity.y = -1000
