extends Node2D
class_name Level

signal sadness

@export var joy_speed:= 5.0
@export var ball_despawn_time:= 1.2
@export var ball_fall_penalty = 20.0

var time_alive: float = 0.0
var joy: float = 50.0:
	set(value):
		joy = max(value, 0)
		if joy == 0:
			sadness.emit()

func _physics_process(delta):
	joy += joy_speed * delta

func _process(delta):
	time_alive += delta

func _on_ball_fall_area_body_entered(body):
	if body is Ball:
		joy -= ball_fall_penalty
		await get_tree().create_timer(ball_despawn_time).timeout
		body.queue_free()


func _on_ball_despawn_body_entered(body):
	if body is Ball:
		body.queue_free()
