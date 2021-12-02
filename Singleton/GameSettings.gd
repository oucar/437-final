extends Node

# GRAVITY
export(float) var GRAVITY = 50

# CAP SPEED
export(float) var TERMINAL_VELOCITY = 300

# GENERATING A RANDOM HIT ANIMATION
export(bool) var should_randomize = true
onready var random_hit_animation = RandomNumberGenerator.new()


func _ready():
	if(should_randomize):
		random_hit_animation.randomize()
