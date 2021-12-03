extends KinematicBody2D

# FOR INHERITANCE
class_name Character

# Global variables
export(int) var health = 3 setget set_health

# Virtual functions
func _get_hit(damage : float):
	push_error("get_hit() has not been implemented for the current character")

# play after hit animation is finished
func _on_hit_finished():
	push_error("on_hit_finished() has not been implemented for the current character")

# generic health setter
func set_health(health_given):
	health = health_given
	
	if(health <= 0):
		queue_free()
