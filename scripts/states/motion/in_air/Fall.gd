extends "res://scripts/states/motion/motion.gd"

var grav = 1000
var fall_vel = Vector2()


func enter():
	fall_vel = velocity
	#Play fall anim
	
func update(delta):
	var input_dir = get_input_direction()
	update_facing()
	
	
	fall_vel.y -= grav * delta
	
	var new_velocity = velocity.x + input_dir * max_speed / accel
	if abs(new_velocity) < max_speed:
		velocity.x = new_velocity
	else: 
		velocity.x = sign(velocity.x)*max_speed
	
	#Friction
	
	if not bool(input_dir) or abs(velocity.x) > max_speed:    # Si no está apretando para moverse o pasó el límite
		var v_sign = sign(velocity.x)
		if v_sign != 0:                                        # Si se está moviendo:
			velocity.x = velocity.x - v_sign * max_speed / deaccel
			if sign(velocity.x) != v_sign:
				velocity.x = 0
	
	_apply_movement()
	
func _apply_movement():
	velocity = owner.move_and_slide(velocity, Vector2.UP)
	on_floor = owner.is_on_floor()	
	
