extends Node

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player.died.connect(Game.restart_scene)
