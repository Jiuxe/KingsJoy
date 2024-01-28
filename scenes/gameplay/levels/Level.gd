extends Node2D
class_name Level

signal sadness

@export var joy_speed:= 5.0
@export var ball_despawn_time:= 1.2
@export var ball_fall_penalty = 20.0

@export var can_lose:= true

var time_alive: float = 0.0
var joy: float = 50.0:
	set(value):
		joy = max(value, 0)
		if joy == 0 and can_lose:
			sadness.emit()

@export var player_name: String

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	joy += joy_speed * delta

func _process(delta):
	if Input.is_action_just_pressed("catalan"):
		Game.change_scene_to_file("res://scenes/menu/menu.tscn")
	time_alive += delta

func pre_start(params):
	if "player_name" in params:
		player_name = params.player_name
	else:
		player_name = "Anonymous"

func _on_ball_fall_area_body_entered(body):
	if body is Ball:
		joy -= ball_fall_penalty
		await get_tree().create_timer(ball_despawn_time).timeout
		body.queue_free()

func _on_ball_despawn_body_entered(body):
	if body is Ball:
		body.queue_free()
