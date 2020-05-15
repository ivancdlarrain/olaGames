extends Area2D

var texture0 = preload("res://assets/sprites/misc/enemy-explosion/Explosion0.png")
var texture1 = preload("res://assets/sprites/misc/enemy-explosion/Explosion1.png")
var texture2 = preload("res://assets/sprites/misc/enemy-explosion/Explosion2.png")

func _ready():
	$AnimationPlayer.play('default')


func _on_RegularExplosion_body_entered(body):
	if body in get_tree().get_nodes_in_group("alive"):
		body.take_damage()


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()


func set_layer(n):
	set_collision_mask_bit(n, true)
	match n:
		0:
			$Sprite.set_texture(texture0)
		1:
			$Sprite.set_texture(texture1)
		2:
			$Sprite.set_texture(texture2)
