extends KinematicBody2D

# USE INSPECTOR!
export(float) var damage = 1
export(float) var move_speed = 150

var target_direction = Vector2.ZERO

func _physics_process(delta):
	# don't use slide! 
	# https://docs.godotengine.org/en/stable/classes/class_kinematicbody.html
	var collide = move_and_collide(move_speed * target_direction * delta)
	
	if(is_instance_valid(collide)):
		queue_free()


func _on_AttackArea_body_shape_entered(body_id, body, body_shape, local_shape):
	print("Debug: Got hit by an enemy!")
	body.get_hit(damage)
	queue_free()
