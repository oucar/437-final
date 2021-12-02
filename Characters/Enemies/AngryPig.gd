extends KinematicBody2D

onready var animated_sprite = $AnimatedSprite

# Waypoints
export(Array, NodePath) var waypoints
export(float) var MOVE_SPEED = 100
export(float) var RUN_SPEED = 300
export(int) var STARTING_WAYPOINT = 0
export(float) var WAYPOINT_ARRIVED_DISTANCE = 10
export(bool) var FACES_RIGHT = true

var waypoint_index = 0 setget set_waypoint_index
var waypoint_position
var velocity = Vector2.ZERO

# function that runs when game starts
func _ready():
	self.waypoint_index = STARTING_WAYPOINT

func _physics_process(delta):
	var direction = self.position.direction_to(waypoint_position)
	# will move horizontally ONLY!
	var direction_horizontal = Vector2(self.position.x, 0).distance_to(Vector2(waypoint_position.x, 0))
	
	if(direction_horizontal >= WAYPOINT_ARRIVED_DISTANCE):
		
		# used to flip the pig sprite when needed
		var horizontal_sign = sign(direction.x)
		
		velocity = Vector2(
			# 200, -200 or 0
			MOVE_SPEED * sign(direction.x),
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
	
	

# SET WAYPOINTS
func set_waypoint_index(value):
	waypoint_index = value
	waypoint_position = get_node(waypoints[value]).position
