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
	call_deferred("init_animations")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	joy += joy_speed * delta

func _process(delta):
	if Input.is_action_just_pressed("catalan"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Game.change_scene_to_file("res://scenes/menu/menu.tscn")
	time_alive += delta

func pre_start(params):
	if "player_name" in params and params.player_name != '':
		player_name = params.player_name
	else:
		player_name = "ANO"

func _on_ball_fall_area_body_entered(body):
	if body is Ball:
		joy -= ball_fall_penalty
		await get_tree().create_timer(ball_despawn_time).timeout
		body.queue_free()

func sad(body):
	var sad = get_node("Sad")
	sad.play()

func _on_ball_despawn_body_entered(body):
	if body is Ball:
		body.queue_free()

func init_animations():
	for npc in get_tree().get_nodes_in_group("NPC"):
		npc.animation_player.play(npc.animation_names.pick_random())
		await get_tree().create_timer(0.12).timeout

		
func laugh():
	var risas = get_node("Risas")
	var resource = "res://assets/music/Risa_"+ str(randi_range(1,4)) +".mp3"
	print(resource)
	risas.stream = ResourceLoader.load(resource)
	risas.play()	
