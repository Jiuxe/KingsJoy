extends Node

@export var level: Level
@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#player.died.connect(Game.restart_scene)
	level.sadness.connect(Game.restart_scene)
