extends DobleStateMachine

func _ready():
	add_state('idle')
	add_state('run')
	add_state('jump')
	add_state('fall')
	add_state('dash')
	add_state('glide')
	add_state('wall_slide')
	call_deferred('set_state', states.idle)
	add_state2('blue')
	add_state2('orange')
	add_state2('purple')
	call_deferred('set_state2', states2.blue)


func _state_logic(delta):
	parent._handle_move_input()
	parent._handle_color_input()
	parent._apply_gravity(delta)
	parent._apply_friction()
	parent._apply_movement()
	print(states.keys()[state])
	print(parent.grav)

func _input(event):
	if [states.idle, states.run].has(state):
		if event.is_action_pressed('WASD_up'):
			parent.velocity.y = -parent.jump_speed
	
	if [states2.orange].has(state2):
		if event.is_action_pressed('WASD_up'):
			if [states.jump, states.fall, states.glide].has(state):
				if parent.double_jump:
					parent.velocity.y = -parent.jump_speed
					parent.double_jump = false
	if [states.wall_slide].has(state):
		if event.is_action_pressed('WASD_up'):
			print('wall slide jump')
			parent._wall_jump()
	if event.is_action_pressed("special"):
		if [states2.blue].has(state2):
			if [states.run].has(state):
				if parent.facing_right:
					parent.velocity.x = parent.max_speed * 3
				else:
					parent.velocity.x = -parent.max_speed * 3
		elif [states2.orange].has(state2):
			pass
					
		else:
			if [states.jump].has(state):
				parent.velocity.y = 0
				parent.grav = parent.glide_grav
			if [states.fall].has(state):
				parent.grav = parent.glide_grav
	
	#Change if needed for another color
	if event.is_action_released("special") or parent.is_on_floor():
		parent.grav = parent.default_grav	
	
	

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
					return states.fall
			if parent.velocity.x == 0:
				return states.idle
			elif parent.velocity.x > parent.max_speed:
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
			else:
				if parent.velocity.y < 0: 
					return states.jump
				
				if parent.grav == parent.glide_grav:
					return states.glide
		states.dash:
			if !on_floor:
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
					return states.run
		
		states.glide:
			if !on_floor:
				if parent.grav == parent.default_grav:
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
				 
			
		
	return null


func _get_transition2(delta):
	var colour = parent.colour_switch
	match state2:
		states2.blue:
			if parent.colour_switch == 1:
				parent.colour_switch = 0
				return states2.orange
			elif parent.colour_switch == -1:
				parent.colour_switch = 0
				return states2.purple
		states2.orange:
			if parent.colour_switch == 1:
				parent.colour_switch = 0
				return states2.purple
			elif parent.colour_switch == -1:
				parent.colour_switch = 0
				return states2.blue
		states2.purple:
			if parent.colour_switch == 1:
				parent.colour_switch = 0
				return states2.blue
			elif parent.colour_switch == -1:
				parent.colour_switch = 0
				return states2.orange
	return null
	
func _enter_state(new_state, old_state):
	pass
			
func _enter_state2(new_state, old_state):
	match new_state:
		states2.blue:
			parent.set_collision_layer_bit(0, true)
			parent.set_collision_mask_bit(0, true)
		states2.orange:
			parent.set_collision_layer_bit(1, true)
			parent.set_collision_mask_bit(1, true)
		states2.purple:
			parent.set_collision_layer_bit(2, true)
			parent.set_collision_mask_bit(2, true)

func _exit_state(old_state, new_state):
	pass
	
func _exit_state2(old_state, new_state):
	match old_state:
		states2.blue:
			parent.set_collision_layer_bit(0, false)
			parent.set_collision_mask_bit(0, false)
		states2.orange:
			parent.set_collision_layer_bit(1, false)
			parent.set_collision_mask_bit(1, false)
		states2.purple:
			parent.set_collision_layer_bit(2, false)
			parent.set_collision_mask_bit(2, false)
		