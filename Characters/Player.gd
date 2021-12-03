extends "res://Characters/Character.gd"

export(float) var move_speed = 150
export(float) var jump_impulse = 500
export(float) var enemy_bounce_impulse = 400
export(float) var knockback_collision_speed = 30
export(float) var wall_slide_friction = 0.6
export(int) var max_jumps = 2
export(float) var jump_damage = 1
export(int) var total_bees_killed = 0

enum STATE { IDLE, RUN, JUMP, DOUBLE_JUMP, HIT, WALL_SLIDE}

onready var animated_sprite = $AnimatedSprite
onready var animation_tree = $AnimationTree
onready var jump_hitbox = $JumpHitbox

# Timers
onready var invincible_timer = $InvincibleTimer
onready var wall_jump_timer = $WallJumpTimer
onready var drop_timer = $DropTimer

signal player_died(player)

var velocity : Vector2

var current_state = STATE.IDLE setget set_current_state
var jumps = 0

# Wall jumping
var wall_jump_direction : Vector2
var is_next_to_wall : bool

func _physics_process(delta):
	var input = get_player_input()
	
	# https://docs.godotengine.org/en/stable/classes/class_kinematicbody2d.html
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# true or false
	is_next_to_wall = raycasting_test()
	set_anim_parameters()
	
	match(current_state):
		STATE.IDLE, STATE.RUN, STATE.JUMP, STATE.DOUBLE_JUMP:
			# handle jumping from the wall
			if(wall_jump_timer.is_stopped()):
				velocity = normal_move(input)
			
			# wall jump
			else:
				velocity = wall_jumping_movement()
				
			pick_next_state()
		STATE.HIT:
			velocity = hit_move()
		STATE.WALL_SLIDE:
			velocity = wall_slide_move()
			pick_next_state()

#####################################
##### GENERIC MOVEMENT, METHODS #####
#####################################

# Move at the normal speed
func normal_move(input):
	adjust_flip_direction(input)
	
	return Vector2(
		input.x * move_speed,
		min(velocity.y + GameSettings.GRAVITY, GameSettings.TERMINAL_VELOCITY)
	)

# Move slower when you got hit or take any damage
# Credits, idea: https://www.youtube.com/watch?v=mm4D1ETclAc
func hit_move():
	var knockback_direction : Vector2
	
	# facing left, knocback should be to the right
	if(animated_sprite.flip_h):
		knockback_direction = Vector2.RIGHT
	# facing right, knocback should be to the left
	else:
		knockback_direction = Vector2.LEFT
		
	knockback_direction = knockback_direction.normalized()
		
	return knockback_collision_speed * knockback_direction
	
func adjust_flip_direction(input : Vector2):
	# no need to check for the y coordinate. 
	# only flip horizontally when needed (Vector2.RIGHT might be used)	
	if(sign(input.x) == 1):
		animated_sprite.flip_h = false
	elif(sign(input.x) == -1):
		animated_sprite.flip_h = true
		
# Uses Input to determine which directions the player is pressing down on for use in movement
func get_player_input():
	 # down is positive in 2D games.
	var input : Vector2
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input


######################
##### WALL SLIDE #####
######################
# https://www.youtube.com/watch?v=w8pC8n4s-_I
# https://www.youtube.com/watch?v=S_b0c4i36FY

func wall_slide_move():
	return Vector2(
		velocity.x,
		min(velocity.y + (GameSettings.GRAVITY * wall_slide_friction), GameSettings.TERMINAL_VELOCITY)
	)
	
func wall_jumping_movement():
	return Vector2(
		move_speed * wall_jump_direction.x,
		min(velocity.y + GameSettings.GRAVITY , GameSettings.TERMINAL_VELOCITY)
	)

# Creates an imaginary boundary and checks if there's a wall! Perfect use of 2D raycasting in Godot.
# RAYCASTING IN GODOT: https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html
# https://www.youtube.com/watch?v=lNADi7kTDJ4
func raycasting_test():
	# access the space - raycast testing
	# check if a collision between the starting and ending point
	var space_state = get_world_2d().direct_space_state
	
	# starting from player's position, all the way to global_position + 10 in the facing direction
	# result is a dictionary - use if else for the size.
	var result = space_state.intersect_ray(global_position, global_position + 10 * get_facing_direction(), [self])
	
	if(result.size() > 0):
		return true
	else:
		return false
		
# returns the facing direction of the Player
func get_facing_direction():
	if(animated_sprite.flip_h == false):
		return Vector2.RIGHT
	else:
		return Vector2.LEFT
		
		
#######################
##### ANIMATIONS ######
#######################	

func set_anim_parameters():
	# required for blend_position and blend! check the docs if needed
	# Facing Left and Right
	animation_tree.set("parameters/x_sign/blend_position", sign(velocity.x))
	# Jump and Fall
	animation_tree.set("parameters/y_sign/blend_amount", sign(velocity.y))
	
	# wall slide
	var is_on_wall_int : int
	
	if(is_next_to_wall):
		is_on_wall_int = 1
	else:
		is_on_wall_int = 0
		
	# CHECK THE ANIMATION TREE!
	animation_tree.set("parameters/is_on_wall/blend_amount", is_on_wall_int)
	
func pick_next_state():
	# available in KinematicBody2D
	if(is_on_floor()):
		jumps = 0
		
		# jump (SPACE) is pressed while the main character is on the ground
		if(Input.is_action_just_pressed("jump")):
			self.current_state = STATE.JUMP
		# character moving horizontally, (Abs - absolute val) -> as long it's not 0.
		elif(abs(velocity.x) > 0):
			self.current_state = STATE.RUN
		# idle
		else:
			self.current_state = STATE.IDLE
	
	# double jump
	# error prone :D - pls don't try to break it even more
	# CREDIT: https://www.youtube.com/watch?v=9lwI-dGvxk8
	elif (Input.is_action_just_pressed("jump") && jumps < max_jumps):
		if(is_next_to_wall):
			self.current_state = STATE.JUMP
		else:
			self.current_state = STATE.DOUBLE_JUMP
	
	# lean on the wall - if next to the wall (Raycasting)
	elif(is_next_to_wall):
		self.current_state = STATE.WALL_SLIDE
		

	elif(self.current_state == STATE.WALL_SLIDE && !is_next_to_wall):
		self.current_state = STATE.JUMP



###################
##### ACTIONS #####
###################

func jump():
	# amount of movement we want to add upwards
	velocity.y = -jump_impulse
	jumps += 1
	
func wall_jump():
	velocity.y = -jump_impulse
	jumps = 1
	wall_jump_direction = -get_facing_direction()
	wall_jump_timer.start()
	
# Fall through one way collision platforms
func drop():
	position.y += 1
	
	pass # Replace with function body.

# Get hit by an enemy
func get_hit(damage : float):
	if(invincible_timer.is_stopped()):
		if(damage >= self.health):
			emit_signal("player_died", self)
		
		self.health -= damage
		self.current_state = STATE.HIT
		# start the timer to make player invicible for a second or so.
		invincible_timer.start()

func die():
	emit_signal("player_died", self)
	queue_free()

# Call when hit animation is finished (required)
func on_hit_finished():
	self.current_state = STATE.IDLE
	
	
	
#####################
###### SIGNALS ######
#####################

func _on_Player_tree_entered():
	GameManager.active_player = self
	
# Hitbox - Jumping on an enemy
func _on_JumpHitbox_area_shape_entered(area_id, area, area_shape, local_shape):
	# check if the thing we're jumping on is an enemy
	var enemy = area.owner
	
	if(enemy is Enemy && enemy.can_be_hit):
		# global position - not relative to anything
		# temprorary fix to hitting to an enemy from below
		if(velocity.y > 0):
			# Jump attack implementation
			velocity.y = -enemy_bounce_impulse
			enemy.get_hit(jump_damage)
		
#####################
###### SETTERS ######
#####################
func set_current_state(new_state):
	match(new_state):
		STATE.JUMP:
			if(current_state == STATE.WALL_SLIDE):
				if(Input.is_action_just_pressed("jump")):
					wall_jump()
			else:
				jump()
		STATE.DOUBLE_JUMP:
			jump()
			animation_tree.set("parameters/double_jump/active", true)
		STATE.HIT:
			animation_tree.set("parameters/hit/active", true)
		STATE.WALL_SLIDE:
			jumps = 0
	
	current_state = new_state
	emit_signal("changed_state", STATE.keys()[new_state], new_state)

