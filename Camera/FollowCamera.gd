extends Camera2D


# https://docs.godotengine.org/en/stable/classes/class_camera2d.html
# Check Scene << 
onready var top_left = $Boundaries/TopLeft
onready var bottom_right = $Boundaries/BottomRight

func _ready():
	# set the limits
	self.limit_top = top_left.global_position.y
	self.limit_left = top_left.global_position.x
	self.limit_bottom = bottom_right.global_position.y
	self.limit_right = bottom_right.global_position.x

