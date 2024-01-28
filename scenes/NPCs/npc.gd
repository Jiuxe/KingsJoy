extends Sprite2D
@onready var animation_player = $AnimationPlayer
@export var mouth_sprite : Texture2D
@export var animation_names : = ["animacion_npc","animacion_npc_2"]
# Called when the node enters the scene tree for the first time.

func _ready():
	animation_player.animation_finished.connect(change_animation)
	if mouth_sprite != null:
		$Sprite2D.texture = mouth_sprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func change_animation(_animation_name):
	animation_player.play(animation_names.pick_random())
	
