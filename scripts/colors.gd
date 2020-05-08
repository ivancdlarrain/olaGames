extends DobleStateMachine

signal color_changed
signal layer_entered
signal layer_exited
signal use_ground_collision

func _ready():
	add_state('idle')
	add_state('run')
	add_state('jump')
	add_state('fall')
	add_state('dash')
	add_state('glide')
	add_state('wall_slide')
	add_state('pre_fall')
	call_deferred('set_state', states.idle)
	add_state2('blue')
	add_state2('orange')
	add_state2('purple')
	call_deferred('set_state2', states2.blue)
	

func _state_logic(delta):
	parent._handle_move_input()
	parent._handle_color_input_arrkeys()
	
	#Apply a cap to the fall speed if the player is wall-sliding
	if [states.wall_slide, states.glide].has(state):
		parent._cap_gravity(delta)
	else:
		parent._apply_gravity(delta)
	parent._apply_friction()
	parent._apply_movement()
	parent._tile_detection()
	
#	print(states.keys()[state])
#	print(states.keys()[state])
	#print(parent.jump_pressed)
#	print(parent.on_floor)
	
func _input(event):
	if event.is_action_pressed('WASD_up'):
		parent.jump_pressed = true
		parent.remember_jump()
	
	if [states.idle, states.run, states.pre_fall].has(state):
		if parent.jump_pressed:
			parent.velocity.y = -parent.jump_speed
				
		
	if [states2.orange].has(state2):
		if event.is_action_pressed('WASD_up'):
			if [states.jump, states.fall, states.glide].has(state):
				if parent.double_jump:
					parent.velocity.y = -parent.jump_speed
					parent.double_jump = false
	if [states.wall_slide].has(state):
		if event.is_action_pressed('WASD_up'):
			
			parent._wall_jump()
	if event.is_action_pressed("special"):
		if [states2.blue].has(state2):
			if [states.run, states.fall, states.jump].has(state) and parent.dash_cd.is_stopped():
				parent.dashing  = true
		elif [states2.orange].has(state2):
			pass
					
		else:
			if [states.jump, states.fall].has(state):
				parent.gliding = true
	#Change if needed for another color
	if event.is_action_released("special") or parent.on_floor or parent.is_on_wall() or ![states2.purple].has(state2):
		parent.gliding = false	
	
	#Make jump height dependant on how much key is pressed:
	if event.is_action_released("WASD_up"):
		if [states.jump].has(state):
			parent.velocity.y = parent.velocity.y * 0.5
	
	

func _get_transition(delta):
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
			
			elif parent.gliding:
				return states.glide
				
			else:
				if parent.velocity.y > 0: 
					return states.fall
				
				if parent.grav == parent.glide_grav:
					return states.glide
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
			elif parent.gliding:
				return states.glide
			else:
				if parent.velocity.y < 0: 
					return states.jump
				
		states.dash:
			if abs(parent.velocity.x) <= parent.max_speed:
				return states.run
		
		states.glide:
			if !on_floor:
				if !parent.gliding:
					return states.fall
			if on_wall:
				states.wall_slide
			if on_floor:
				if parent.velocity.x == 0:
					return states.idle
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

func _get_transition2(delta):
	var colour = parent.colour_switch
	match colour:
		0:
			return states2.blue
		1:
			return states2.orange
		2:
			return states2.purple
func _enter_state(new_state, old_state):
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
			parent.velocity.y = 0
			if parent.facing_right:
					parent.velocity.x = parent.max_speed * 3
			else:
					parent.velocity.x = -parent.max_speed * 3
		states.glide:
			emit_signal("use_ground_collision", false)
			parent.playback.travel("fall")
			parent.grav = parent.glide_grav	
			if parent.velocity.y < 0:
				parent.velocity.y = 0
		states.wall_slide:
			emit_signal("use_ground_collision", false)
			parent.playback.travel("fall")
		states.pre_fall:
			emit_signal("use_ground_collision", true)
			parent.playback.travel("run")
			parent.grav = 0
			parent.c_timer.start()
			
func _enter_state2(new_state, old_state):
	# This function sets the player on the corresponding collision layer and changes its color 
	# by using signals connected to Player.gd
	match new_state:
		states2.blue:
			emit_signal("color_changed", Color(0, 0.972549, 1))
			emit_signal("layer_entered", 0)
		states2.orange:
			emit_signal("color_changed", Color(1, 0.529412, 0))
			emit_signal("layer_entered", 1)
		states2.purple:
			emit_signal("color_changed",Color(0.85098, 0, 1))
			emit_signal("layer_entered", 2)

func _exit_state(old_state, new_state):
	match old_state:
		states.pre_fall:
			parent.grav = parent.default_grav
		states.dash:
			parent.grav = parent.default_grav
			parent.dashing = false
			parent.dash_cd.start()
		states.glide:
			parent.grav = parent.default_grav
	
func _exit_state2(old_state, new_state):
	# This function removes the player from the corresponding collision layer 
	# by using signals connected to Player.gd
	match old_state:
		states2.blue:
			emit_signal("layer_exited", 0)
		states2.orange:
			emit_signal("layer_exited", 1)
		states2.purple:
			emit_signal("layer_exited", 2)
		
