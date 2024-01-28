extends Node2D
@onready var actor : CharacterBody2D = $Toni
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var player_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("joystick")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("catalan"):
		var params = {
			"player_name": player_name
		}
		Game.change_scene_to_file("res://scenes/gameplay/levels/TestLevelToni2.tscn", params)
	
