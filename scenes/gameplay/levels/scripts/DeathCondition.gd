extends Node

@export var level: Level
@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#player.died.connect(Game.restart_scene)
	level.sadness.connect(end_game)

func end_game():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var params = {
		"player_name": level.player_name,
		"time_alive": level.time_alive * 100
	}
	
	Game.change_scene_to_file("res://scenes/menu/end_game.tscn", params)
