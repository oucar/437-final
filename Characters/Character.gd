extends KinematicBody2D

# will be used for the healthbar
signal health_changed(new_health)


export(int) var health = 3 setget set_health

func set_health(value):
	if(health != value):
		emit_signal("health_changed", value)
	health = value
	if(health <= 0):
		# remove the instance from the world
		queue_free()
		
	# FOR DEBUGGING
	if(self.health != 0):
		print("Debug: Hit detected!")
	else:
		print("Debug: Instance died!")
		# total_bees

#############################
##### VIRTUAL FUNCTIONS #####
#############################
func _get_hit(damage : float):
	pass
	
func _on_hit_finished():
	pass

