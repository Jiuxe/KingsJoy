extends Node2D

var list_marker = []
var ball = preload("res://scenes/gameplay/ball/ball.tscn")
@onready var timer = $Timer


func _ready():
	
	timer.timeout.connect(spawn_ball)
	
	for marker in get_children():
		if marker is Marker2D:
			list_marker.append(marker)
			
	print(list_marker)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	
	if Input.is_action_just_pressed("ui_accept"):
		spawn_ball()
		


func spawn_ball():
	
	var generate_in_marker = list_marker[randi_range(0,list_marker.size()-1)]
	var new_ball = ball.instantiate()
	add_child(new_ball)
	
	new_ball.position = generate_in_marker.position
