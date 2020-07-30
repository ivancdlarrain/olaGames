extends DroneStateMachine

onready var color = get_parent().get_node("ColorState")

# Flags:
var orange_collision = false
var recovery_finished = false
var finished_color_change = false
var on_range = false

# Purple attack flags:
var remaining_drones = 0


func _ready():
	._ready()
	add_state('idle')
	add_state('chase')
	add_state('main')
	add_state('secondary')
	add_state('recovery')
	add_state('changing_color')
	call_deferred('set_state', states.idle)


func _state_logic(delta):
	print(states.keys()[state])
	._state_logic(delta)
	match state:
		states.idle:
			parent.apply_deaccel()
		
		states.chase:
			parent.horizontal_movement(ray_direction.x > 0)
		
		states.main:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					parent.move_and_slide(parent.velocity)
				
				color.states.purple:
#					print(len(parent.minions))
					parent.horizontal_movement(ray_direction.x > 0)
		
		states.secondary:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					parent.move_and_slide(parent.velocity)
				
				color.states.purple:
					pass
		
		states.recovery:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					if parent.get_position().y > parent.y_level:
						parent.back_to_y_level()
					
					else:
						recovery_finished = true
						parent.velocity.y = 0
				
				color.states.purple:
					recovery_finished = true
		
		states.changing_color:
			yield(get_tree().create_timer(1), "timeout")
			finished_color_change = true


func _get_transition(delta):
	match state:
		states.idle:
			if found:
				return states.chase
		
		states.chase:
			if on_range:
				if randi()%4+1 == 1:
					return states.main
				
				else:
					return states.secondary
			
			if !found:
				return states.idle
		
		states.main:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					if orange_collision:
						return states.recovery
				
				color.states.purple:
					if remaining_drones == 0:
						return states.recovery
		
		states.secondary:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					if orange_collision:
						return states.recovery
				
				color.states.purple:
					pass
		
		states.recovery:
			if recovery_finished:
				match previous_state:
					states.main:
						return states.changing_color
					
					states.secondary:
						return states.chase
		
		states.changing_color:
			if finished_color_change:
				return states.idle
		
	return null


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
		
		states.chase:
			pass
		
		states.main:
			parent.main_attack()
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					pass
				
				color.states.purple:
					remaining_drones = 3
		
		states.secondary:
			parent.secondary_attack()
		
		states.recovery:
			pass
		
		states.changing_color:
			color.changing_color = true


func _exit_state(old_state, new_state):
	match old_state:
		states.idle:
			pass
		
		states.chase:
			pass
		
		states.main:
			parent.take_damage()
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					orange_collision = false
					parent.summon_explosion(parent.position, 1, 2)
				
				color.states.purple:
					pass
		
		states.secondary:
			match color.state:
				color.states.blue:
					pass
				
				color.states.orange:
					orange_collision = false
					parent.summon_explosion(parent.position, 1, 2)
				
				color.states.purple:
					pass
		
		states.recovery:
			recovery_finished = false
		
		states.changing_color:
			finished_color_change = false



# Some connections:
func _on_DestructionArea_body_entered(_body):
	if state in [states.main, states.secondary] and color.state == color.states.orange:
		orange_collision = true


func _on_OrangeRange_body_entered(body):
	if body in get_tree().get_nodes_in_group("drone_target") and color.state in [color.states.orange, color.states.purple]:
		on_range = true


func _on_OrangeRange_body_exited(body):
	if body in get_tree().get_nodes_in_group("drone_target") and color.state in [color.states.orange, color.states.purple]:
		on_range = false
