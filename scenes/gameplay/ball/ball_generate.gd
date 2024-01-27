extends Node2D

var list_marker = []
var ball = preload("res://scenes/gameplay/ball/ball.tscn")
@onready var timer = $Timer
@export var spawn_time: float = 10.0


func _ready():
	timer.wait_time = spawn_time
	timer.timeout.connect(spawn_ball)
	for marker in get_children():
		if marker is Marker2D:
			list_marker.append(marker)


func spawn_ball():
	var generate_in_marker = list_marker[randi_range(0,list_marker.size()-1)]
	var new_ball = ball.instantiate()
	add_child(new_ball)
	new_ball.color = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))
	
	new_ball.global_position = generate_in_marker.global_position
	var rotation_rads = deg_to_rad(randi_range(-55, -45))
	var throw_force = randf_range(0.6, 1.2)
	new_ball.jump(rotation_rads, throw_force)
