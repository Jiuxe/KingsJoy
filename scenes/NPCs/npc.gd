extends Sprite2D
@onready var animation_player = $AnimationPlayer
@export var mouth_sprite : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("animacion_npc")
	if mouth_sprite != null:
		$Sprite2D.texture = mouth_sprite
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
