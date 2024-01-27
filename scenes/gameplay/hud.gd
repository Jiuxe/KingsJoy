extends CanvasLayer

@onready var timer_label = %TimerLabel
@onready var joy_bar = %JoyBar

@export var level: Level

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	if level == null and parent is Level:
		level = parent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer_label.text = format_time(level.time_alive)
	joy_bar.value = level.joy


func format_time(time_sec: float):
	var minutes = int(time_sec / 60)
	var seconds = int(time_sec) % 60
	return "%02d" % minutes + ":" + "%02d" % seconds
