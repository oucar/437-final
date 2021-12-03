extends Character

# FOR INHERITANCE
class_name Enemy

# Global variables
export(bool) var can_be_hit = true
export(float) var collision_damage = 1

# Enemies ollide and hurts player
func _on_EnemyCollisionHitbox_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	# check if player
	body.get_hit(collision_damage)
