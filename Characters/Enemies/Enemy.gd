extends KinematicBody2D

# FOR INHERITANCE
class_name Enemy

# Global variables
export(int) var health = 3
export(bool) var can_be_hit = true


# Enemy gets hit
func get_hit(damage : float):
	health -= damage
	can_be_hit = false
