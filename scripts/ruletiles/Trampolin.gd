extends StaticBody2D

var pushed


func _on_effect_zone_body_entered(body):
	$AnimationPlayer.play('starting')
	pushed = body
	print(body)

func _on_AnimationPlayer_animation_finished(anim_name):
	if pushed in $"effect zone".get_overlapping_bodies():
		pushed.velocity.y = -1000
