extends Node

# Play the music
# Credits: https://www.youtube.com/watch?v=YiLPo72GZs0
onready var music_player = $AudioStreamPlayer2D

var active_player setget set_active_player

signal game_over()

func set_active_player(player):
	if(active_player != player):
		# make sure if it's still there 
		# otherwise null player throws an error
		if(is_instance_valid(active_player)):
			active_player.disconnect("player_died", self, "on_player_died")
	
		active_player = player
		active_player.connect("player_died", self, "on_player_died")

func on_player_died(player):
	emit_signal("game_over")
	music_player.play()
