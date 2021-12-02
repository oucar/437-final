extends KinematicBody2D

# GLOBAL VARIABLES
var velocity : Vector2
onready var animation_tree = $AnimationTree
onready var animated_sprite = $AnimatedSprite

# export will be publicly viewable in Inspector
export(float) var MOVE_SPEED = 200;
export(float) var jump_impulse = 600

# turn human readable string into index
enum STATE { IDLE, RUN, JUMP, DOUBLE_JUMP, WALL_JUMP, HIT, FALL }
var current_state = STATE.IDLE setget set_current_state
var max_jumps = 2
var jumps = 0

##### FUNCTIONS ####

# Generic physics process
func _physics_process(delta):
	var input = get_player_input()
	flip_direction_handler(input)
	
	velocity = Vector2(
		input.x * MOVE_SPEED,
		min(velocity.y + GameSettings.GRAVITY, GameSettings.TERMINAL_VELOCITY)
	)

	# Vector2.UP -> Direction of UP direction (check documentation)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	set_anim_parameters()
	pick_next_state()
	
# Animation Tree
func set_anim_parameters():
	# required for blend_position and blend! check the docs if needed
	# Facing Left and Right
	animation_tree.set("parameters/x_move/blend_position", sign(velocity.x))
	
	# Jump and Fall
	animation_tree.set("parameters/y_move/blend_amount", sign(velocity.y))

# Flip the sprite to when moving right or left (only when needed)	
func flip_direction_handler(input : Vector2):
	# x vector is positive -> look right
	if(sign(input.x) == 1):
		animated_sprite.flip_h = false
	# x vector is negative -> look left
	elif(sign(input.x) == -1):
		animated_sprite.flip_h = true
	
	
# Change the current state depending on the input and current state
func pick_next_state():
	# available in KinematicBody2D
	print(jumps, max_jumps)
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
		
	else:
		if(Input.is_action_just_pressed("jump") && (jumps < max_jumps) ):
			self.current_state = STATE.DOUBLE_JUMP


	

func get_player_input():
	var input: Vector2
	
	# down is positive in 2D games.
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left");
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up");
	
	return input
	
	
# ACTION FUNCTIONS
func jump():
	# amount of movement we want to add upwards
	velocity.y = -jump_impulse
	jumps += 1
	


# SETTERS AND GETTERS
func set_current_state(new_state):
	match(new_state):
		STATE.JUMP:
			jump()
		STATE.DOUBLE_JUMP:
			jump()
			animation_tree.set("parameters/double_jump/active", true)
			
	
