extends Enemy


enum STATE { IDLE, HIT, ATTACK }
var current_state = STATE.IDLE setget set_current_state


# moving between the waypoints
export(float) var fly_speed = 50

# https://docs.godotengine.org/en/stable/classes/class_packedscene.html#tutorials
# For projectile - bee sting
export(PackedScene) var projectile

# direction that bee will launching its sting
var attack_direction
# current target for the sting (only 1 at a time)
var attack_target

# DECREASE THE ATTACK TIME FOR LEVEL 2!!
onready var attack_timer = $AttackTimer
onready var enemy_collision_hitbox = $EnemyCollisionHitbox
onready var launch_position = $LaunchPosition

func _physics_process(delta):
	match(current_state):
		# move between the waypoints
		STATE.IDLE:
			waypoint_move(delta)
			
			# attack the player only when attack timer is NOT running
			# and target is a valid player!!
			if(is_instance_valid(attack_target) && attack_timer.is_stopped()):
				self.current_state = STATE.ATTACK
				attack_direction = self.position.direction_to(attack_target.position)
				attack_timer.start()
		STATE.ATTACK:
			waypoint_move(delta)
			
func _get_move_velocity(delta, direction):
	return fly_speed * direction

func get_hit(damage: float):
	self.health -= damage
	self.current_state = STATE.HIT
	

# Launches a projectile at the current attack_target with the attack_direction
func launch_projectile(target_direction : Vector2):
	var launched_projectile = projectile.instance()
	launched_projectile.global_position = launch_position.global_position
	launched_projectile.rotation += target_direction.angle()
	get_tree().get_current_scene().add_child(launched_projectile)
	launched_projectile.target_direction = target_direction
	
####################################
###### ANIMATION-TREE RELATED ######
####################################
func set_current_state(new_state):
	match(new_state):
		# "monitoring", true -> enemy can deal player damage
		# "monitoring", false -> enemy cannot deal player damage
		STATE.IDLE:
			enemy_collision_hitbox.set_deferred("monitoring", true)
			# for player
			can_be_hit = true
			
		STATE.ATTACK:
			enemy_collision_hitbox.set_deferred("monitoring", true)
			can_be_hit = true
			animation_tree.set("parameters/attack/active", true)
			
		STATE.HIT:
			enemy_collision_hitbox.set_deferred("monitoring", false)
			can_be_hit = false
			animation_tree.set("parameters/hit/active", true)
			
			# enemy will wait for {seconds} until starts attacking again
			# DO NOT REMOVE!
			attack_timer.start()
	
	current_state = new_state
	
func _hit_animation_finished():
	self.current_state = STATE.IDLE
	
func _attack_animation_finished():
	self.current_state = STATE.IDLE
	launch_projectile(attack_direction)

###################
##### SIGNALS #####
###################
func _on_ProjectileAttackArea_body_shape_entered(body_id, body, body_shape, local_shape):
	print("Debug: Enemy detected the player.")
	attack_target = body
	
	
func _on_ProjectileAttackArea_body_shape_exited(body_id, body, body_shape, local_shape):
	print("Debug: Enemy lost the player.")
	attack_target = null

	


