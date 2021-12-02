extends KinematicBody2D

# FOR INHERITANCE
class_name Character

# Global variables
export(int) var health = 3

# Virtual functions
func _get_hit(damage : float):
	push_error("get_hit() has not been implemented for the current character")

func _on_hit_finished():
	push_error("on_hit_finished() has not been implemented for the current character")
