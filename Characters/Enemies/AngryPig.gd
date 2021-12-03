extends Enemy

onready var animated_sprite = $AnimatedSprite
onready var animation_tree = $AnimationTree

enum STATE { WALK, RUN, HIT }

# Waypoints
export(Array, NodePath) var waypoints
export(float) var WALK_SPEED = 75
export(float) var RUN_SPEED = 150
export(int) var STARTING_WAYPOINT = 0
export(float) var WAYPOINT_ARRIVED_DISTANCE = 10
export(bool) var FACES_RIGHT = true

var waypoint_index = 0 setget set_waypoint_index
var waypoint_position
var velocity = Vector2.ZERO
var current_state = STATE.WALK


# function that runs when game starts
func _ready():
	self.waypoint_index = STARTING_WAYPOINT

func _physics_process(delta):
	var direction = self.position.direction_to(waypoint_position)
	# will move horizontally ONLY!
	var direction_horizontal = Vector2(self.position.x, 0).distance_to(Vector2(waypoint_position.x, 0))
	
	if(direction_horizontal >= WAYPOINT_ARRIVED_DISTANCE):
		
		# used to change the move_speed when the pig detects the player
		var move_speed: float
		match(current_state):
			STATE.WALK:
				move_speed = WALK_SPEED
			STATE.RUN:
				move_speed = RUN_SPEED
		
		# used to flip the pig sprite when needed
		var horizontal_sign = sign(direction.x)
		
		velocity = Vector2(
			# 200, -200 or 0
			move_speed * sign(direction.x),
			min(velocity.y + GameSettings.GRAVITY, GameSettings.TERMINAL_VELOCITY)	
		)
		
		# FLIP WHEN NEEDED
		if(horizontal_sign == -1):
			animated_sprite.flip_h = !FACES_RIGHT
		elif(horizontal_sign == 1):
			animated_sprite.flip_h = FACES_RIGHT
		
		
		move_and_slide(velocity, Vector2.UP)
		
	else:
		# current amount of waypoints
		var num_waypoints = waypoints.size()
			
		# loop through the waypoints array until we get to the starting point
		if(waypoint_index < num_waypoints-1):
			self.waypoint_index += 1
			
		else:
			self.waypoint_index = 0

# Player detection
# Player Detection > Collision > Layers (only triggered by the player!)
func _on_PlayerDetection_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	animation_tree.set("parameters/player_detected/blend_position", 1)

	if (current_state == STATE.WALK):
		current_state = STATE.RUN

func _on_PlayerDetection_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	animation_tree.set("parameters/player_detected/blend_position", 0)
	current_state = STATE.WALK
	

	
# Run when hit animation is finished
func hit_animation_finished():
	can_be_hit = true
	current_state = STATE.RUN	


func get_hit(damage : float):
	print("!!")
	# Character.gd - check setget
	self.health -= damage
	
	if(health <= 0):
		# remove the scene
		queue_free()
		

	can_be_hit = false
	current_state = STATE.HIT
	
	# randomly select a hit animation
	var animation_selection = GameSettings.random_hit_animation.randf_range(0, 1)
	
	animation_tree.set("parameters/hit/active", true)
	animation_tree.set("parameters/hit_vartiaton/blend_amount", animation_selection)


# SET WAYPOINTS
func set_waypoint_index(value):
	waypoint_index = value
	waypoint_position = get_node(waypoints[value]).position





