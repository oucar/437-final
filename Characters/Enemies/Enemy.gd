# extends Character
extends "res://Characters/Character.gd"

# FOR INHERITANCE
class_name Enemy

# REFERENCES
onready var animated_sprite = $AnimatedSprite
onready var animation_tree = $AnimationTree

# WAYPOINTS
export(Array, NodePath) var waypoints
export(float) var WAYPOINT_ARRIVED_DISTANCE = 10
export(int) var starting_waypoint = 0
onready var waypoint_index = starting_waypoint setget set_waypoint_index
var waypoint_position 


# Global variables for damage and collision handling
export(bool) var can_be_hit = true
export(float) var collision_damage = 1

var velocity : Vector2 = Vector2.ZERO

# Run everytime game starts
func _ready():
	if(waypoints.size() > 0):
		waypoint_position = get_node(waypoints[starting_waypoint]).position

func waypoint_move(delta):
	if(waypoints.size() > 0):
		var direction = self.position.direction_to(waypoint_position)
		var distance = _get_distance_to_waypoint(waypoint_position)
		
		if(distance >= WAYPOINT_ARRIVED_DISTANCE):
			velocity = _get_move_velocity(delta, direction)
			# VECTOR2.UP
			velocity = move_and_slide(velocity, Vector2.UP)
			
		else:
			var num_waypoints = waypoints.size()
			
			# Loop through each waypoint until getting back to the starting waypoint
			if(waypoint_index < num_waypoints-1):
				self.waypoint_index += 1
			else:
				self.waypoint_index = 0
	
##### SIGNAL #####
# Bee collision
func _on_EnemyCollisionHitbox_body_shape_entered(body_id, body, body_shape, local_shape):
	body.get_hit(collision_damage)

##### VIRTUAL FUNCTIONS ######
func _get_distance_to_waypoint(waypoint_position):
	return self.position.distance_to(waypoint_position)
			
func _get_move_velocity(_delta, _direction):
	pass
	
##### SETTERS #####
func set_waypoint_index(value):
	waypoint_index = value
	waypoint_position = get_node(waypoints[value]).position
