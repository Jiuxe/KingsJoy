extends Node2D

var player_name:String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pre_start(params):

	player_name = params.name
	print(player_name)
   # setup your scene here

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
