extends StateMachine

signal use_ground_collision
onready var color = parent.get_node('ColorState')

func _ready():
	add_state('idle')
	add_state('run')
	add_state('jump')
	add_state('fall')
	add_state('dash')
	add_state('wall_slide')
	add_state('pre_fall')
	call_deferred('set_state', states.idle)
	

func _state_logic(delta):
	if [states.idle, states.run].has(state):    # Ground physics
		parent._handle_horizontal_move_input()
		parent._apply_gravity(delta)
		parent._apply_friction()
		if !parent.j_timer.is_stopped():
			parent.jump()
			parent.j_timer.stop()
		parent._apply_movement()
		parent._tile_detection()

	elif [states.jump, states.fall].has(state):
		parent._handle_horizontal_move_input()
		parent._apply_gravity(delta)
		parent._apply_friction()
		parent._apply_movement()
		parent._tile_detection()
	else:          
		match state:
			states.wall_slide:
				parent._handle_horizontal_move_input()
				parent._cap_gravity(delta)
				if Input.is_action_just_pressed("WASD_up"):
					parent._wall_jump()
				parent._apply_movement()
				parent._tile_detection()
			
			states.dash:    # No grav or move input
				parent._apply_friction()
				parent._apply_movement()
				parent._tile_detection()
			
			states.pre_fall:
				parent._handle_horizontal_move_input()
				if !parent.j_timer.is_stopped():
					parent.jump()
					parent.j_timer.stop()
				parent._apply_movement()
				parent._tile_detection()


func common_input_rest(event):
	if event.is_action_released('WASD_up'):
		if states.jump == state:
			parent.velocity.y = parent.velocity.y * 0.5


func _input(event):
	match color.state:
		color.states.blue:
			if event.is_action_pressed("special"):
				if [states.run, states.fall, states.jump].has(state) and parent.dash_cd.is_stopped():
					parent.dashing  = true
			elif event.is_action_pressed('WASD_up') and !states.wall_slide == state:
				parent.j_timer.start()
			else:
				common_input_rest(event)
		
		color.states.orange:
			if event.is_action_pressed('WASD_up'):
				if [states.jump, states.fall].has(state) and (parent.double_jump or parent.dj_cd.is_stopped()):
					parent.velocity.y = -parent.jump_speed
					parent.double_jump = false
					parent.dj_cd.start()
				else:
					parent.j_timer.start()
			else:
				common_input_rest(event)
		
		color.states.purple:
			if event.is_action_pressed('WASD_up') and state != states.wall_slide:
				parent.j_timer.start()


func _get_transition(_delta):
	var on_floor = parent.is_on_floor()
	var on_wall = parent.is_on_wall()
	match state:
		states.idle:
			if !on_floor:
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
					return states.run
		states.run:
			if !on_floor:
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.pre_fall
			if parent.velocity.x == 0:
				return states.idle
			elif parent.dashing:
				return states.dash
		states.jump:
			if on_floor:
				parent.double_jump = true
				parent.dj_cd.stop()
				if parent.velocity.x == 0: 
					return states.idle
				else: 
					return states.run
			elif on_wall:
				return states.wall_slide
			
			elif parent.dashing:
				return states.dash
			
			elif parent.velocity.y > 0: 
					return states.fall
			
		states.fall:
			if on_floor:
				parent.double_jump = true
				if parent.velocity.x == 0: 
					return states.idle
				else: 
					return states.run
			elif on_wall:
				
				return states.wall_slide
			elif parent.dashing:
				return states.dash

			else:
				if parent.velocity.y < 0: 
					return states.jump
		
		states.dash:
			if on_wall: return states.wall_slide
			if abs(parent.velocity.x) <= parent.max_speed:
				if !on_floor:
					return states.fall
				else:
					return states.run
		
		states.wall_slide:
			if on_floor:
				return states.idle
			
			if !on_wall:
				return states.fall
				 
		states.pre_fall:
			if !parent.c_timer.is_stopped():
				if parent.velocity.y < 0:
					return states.jump
			else:
				return states.fall
		
	return null


func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			emit_signal("use_ground_collision", true)
			parent.playback.travel("idle")
		states.run:
			emit_signal("use_ground_collision", true)
			parent.playback.travel("run")
		states.jump:
			emit_signal("use_ground_collision", false)
			parent.playback.travel("jump")
		states.fall:
			emit_signal("use_ground_collision", false)
			parent.playback.travel("fall")
		states.dash:
			emit_signal("use_ground_collision", true)
			parent.dashParticles.emitting = true
			parent.playback.travel("run")
			var x = parent.max_speed * 3.3 if parent.facing_right else parent.max_speed * -3.3
			parent.velocity = parent.move_and_slide(Vector2(x, 0))
		states.wall_slide:
			emit_signal("use_ground_collision", false)
			parent.playback.travel("fall")
			parent.double_jump = true

		states.pre_fall:
			emit_signal("use_ground_collision", true)
			parent.playback.travel("run")
			parent.c_timer.start()


func _exit_state(old_state, new_state):
	match old_state:
		states.dash:
			parent.dashing = false
			parent.dash_cd.start()
			if new_state == states.wall_slide:
				parent.velocity = parent.move_and_slide(Vector2(0, -parent.max_speed))
