extends KinematicBody2D

# GLOBAL VARIABLES
var velocity : Vector2

# export will be publicly viewable in Inspector
export(float) var MOVE_SPEED = 200;


##### FUNCTIONS ####
func _physics_process(delta):
	var input = get_player_input()
	
	velocity = Vector2(
		input.x * MOVE_SPEED,
		min(velocity.y + GameSettings.GRAVITY, GameSettings.TERMINAL_VELOCITY)
	)
	
	print(velocity.y)
	move_and_slide(velocity)
	
	
func get_player_input():
	var input: Vector2
	
	# down is positive in 2D games.
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left");
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up");
	
	return input


	
	

