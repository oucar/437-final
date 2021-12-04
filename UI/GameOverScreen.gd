extends Control

onready var screen = $Screen
onready var timer = $Timer
onready var label = $Screen/EnemyKilledVariableLabel
onready var total_killed = GameSettings.TOTAL_BEES_KILLED

# Called when the node enters the scene tree for the first time.
func _ready():
	screen.visible = false
	GameManager.connect("game_over", self, "_on_game_over")

func _process(delta):
	if(!timer.is_stopped()):
		var current_alpha = 1 - (timer.time_left / timer.wait_time)
		
		screen.modulate = Color(1,1,1, current_alpha)

func _on_game_over():
	print("FINAL:  ", GameSettings.TOTAL_BEES_KILLED)
	label.text = str(GameSettings.TOTAL_BEES_KILLED)
	screen.visible = true
	screen.modulate = Color(1,1,1,0)
	timer.start()


func _on_Timer_timeout():
	screen.modulate = Color(1,1,1,1)
