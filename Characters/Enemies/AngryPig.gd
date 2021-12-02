extends KinematicBody2D

# Waypoints
export(Array, NodePath) var waypoints
export(float) var MOVE_SPEED = 200
export(float) var RUN_SPEED = 300
export(int) var STARTING_WAYPOINT = 0
export(float) var WAYPOINT_ARRIVED_DISTANCE = 10

var waypoint_index = 0 setget set_waypoint_index
var waypoint_position
var velocity = Vector2.ZERO

# function that runs when game starts
func _ready():
	self.waypoint_index = STARTING_WAYPOINT

func _physics_process(delta):
	var direction = self.position.direction_to(waypoint_position)
	var direction_horizontal = abs(self.position.x) - abs(waypoint_position.x)
	
	if(direction_horizontal >= WAYPOINT_ARRIVED_DISTANCE):
		velocity = Vector2(
			# 200, -200 or 0
			MOVE_SPEED * sign(direction.x),
			min(velocity.y + GameSettings.gravity, GameSettings.terminal_velocity)	
		)
		
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
