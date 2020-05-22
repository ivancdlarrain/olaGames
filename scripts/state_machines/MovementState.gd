extends StateMachine

signal use_ground_collision
onready var color = parent.get_node('ColorState')

func _ready():
	add_state('idle')
	add_state('run')
	add_state('jump')
	add_state('fall')
	add_state('dash')
#	add_state('glide')
	add_state('wall_slide')
	add_state('pre_fall')
	call_deferred('set_state', states.idle)
	

func _state_logic(delta):
	parent._handle_horizontal_move_input()
	#Apply a cap to the fall speed if the player is wall-sliding
#	if [states.wall_slide, states.glide].has(state):
	if states.wall_slide ==state:
		parent._cap_gravity(delta)
	else:
		parent._apply_gravity(delta)
	parent._apply_friction()
	parent._apply_movement()
	parent._tile_detection()


func _input(event):
	if event.is_action_pressed('WASD_up'):
		if [states.wall_slide].has(state):
			parent._wall_jump()
			parent.double_jump = true
		elif color.state == color.states.orange:
#			if [states.jump, states.fall, states.glide].has(state) and (parent.double_jump or parent.dj_cd.is_stopped()):
			if [states.jump, states.fall].has(state) and (parent.double_jump or parent.dj_cd.is_stopped()):
				parent.velocity.y = -parent.jump_speed
				parent.double_jump = false
				parent.dj_cd.start()
			else: 
				parent.j_timer.start()
		else:
			parent.j_timer.start()
		
	elif event.is_action_released("WASD_up"):
		if [states.jump].has(state):
			parent.velocity.y = parent.velocity.y * 0.5
	
	if [states.idle, states.run, states.pre_fall].has(state) and !parent.j_timer.is_stopped():
			parent.velocity.y = -parent.jump_speed
	
	match color.state:
		color.states.blue:
			if event.is_action_pressed("special"):
				if [states.run, states.fall, states.jump].has(state) and parent.dash_cd.is_stopped():
					parent.dashing  = true
		color.states.orange:
			pass
		color.states.purple:
			if event.is_action_pressed("special"):
#				if [states.jump, states.fall].has(state):
#					parent.gliding = true
				pass
			elif event.is_action_released("special") or parent.on_floor or parent.is_on_wall():
				parent.gliding = false	


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
				if parent.velocity.x == 0: 
					return states.idle
				else: 
					return states.run
			elif on_wall:
				return states.wall_slide
			
			elif parent.dashing:
				return states.dash
			
#			elif parent.gliding:
#				return states.glide
				
			else:
				if parent.velocity.y > 0: 
					return states.fall
				
#				if parent.grav == parent.glide_grav:
#					return states.glide
		states.fall:
			if on_floor:
				parent.double_jump = true
				parent.grav = parent.default_grav
				if parent.velocity.x == 0: 
					return states.idle
				else: 
					return states.run
			elif on_wall:
				return states.wall_slide
			elif parent.dashing:
				return states.dash
#			elif parent.gliding:
#				return states.glide
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
		
#		states.glide:
#			if !on_floor:
#				if !parent.gliding:
#					return states.fall
#			if on_wall:
#				return states.wall_slide
#			if on_floor:
#				if parent.velocity.x == 0:
#					return states.idle
#				else:
#					return states.run
		
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
			parent.playback.travel("run")
			parent.grav = 0
			var x = parent.max_speed * 3.3 if parent.facing_right else parent.max_speed * -3.3
			parent.velocity = parent.move_and_slide(Vector2(x, 0))
#		states.glide:
#			emit_signal("use_ground_collision", false)
#			parent.playback.travel("fall")
#			parent.grav = parent.glide_grav	
#			if parent.velocity.y < 0:
#				parent.velocity.y = 0
		states.wall_slide:
			emit_signal("use_ground_collision", false)
			parent.playback.travel("fall")
		states.pre_fall:
			emit_signal("use_ground_collision", true)
			parent.playback.travel("run")
			parent.grav = 0
			parent.c_timer.start()


func _exit_state(old_state, new_state):
	match old_state:
		states.pre_fall:
			parent.grav = parent.default_grav
		states.dash:
			parent.grav = parent.default_grav
			parent.dashing = false
			parent.dash_cd.start()
			if new_state == states.wall_slide:
				parent.velocity = parent.move_and_slide(Vector2(0, -parent.max_speed))
#		states.glide:
#			parent.grav = parent.default_grav
