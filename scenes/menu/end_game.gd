extends Control
@onready var play_button = $MarginContainer/Control/VBoxContainer/PlayButton

var ranking = []

func _ready():
	play_button.grab_focus()
	pass
	
func pre_start(params):
	
	load_ranking()
	
	ranking.append({"player_name":params.player_name, "score": str(int(params.time_alive))})
	ranking.sort_custom(func(a, b): return int(a.score) > int(b.score))

	if ranking.size() > 3:
		ranking.pop_back()
	
	var ranking_box = get_node("MarginContainer/Control/Ranking").get_children()
	
	for box in ranking_box:
		var score = box.get_node("HBoxContainer/Tiempo")
		var player_name = box.get_node("HBoxContainer/Nombre")
		
		if ranking.size() > box.get_index():
			score.text = ranking[box.get_index()].score
			player_name.text = ranking[box.get_index()].player_name
	
	save_ranking()

	
	
func save_ranking():
	var file = FileAccess.new
	file = FileAccess.open("user://save_game.save", FileAccess.WRITE)	

	for player in ranking:
		file.store_line(JSON.stringify(player))
	file.close()

func load_ranking():
	var file = FileAccess.new
	var file_name = "user://save_game.save"
	
	if not FileAccess.file_exists(file_name):
		return
	
	file = FileAccess.open(file_name, FileAccess.READ)
	var json = JSON.new()
	while file.get_position() < file.get_length():
		ranking.append(json.parse_string(file.get_line()))
	
	file.close()

	
func _on_PlayButton_pressed() -> void:
	Game.change_scene_to_file("res://scenes/menu/menu.tscn")
	

func _on_ExitButton_pressed() -> void:
	# gently shutdown the game
	var transitions = get_node_or_null("/root/Transitions")
	if transitions:
		transitions.fade_in({
			'show_progress_bar': false
		})
		await transitions.anim.animation_finished
		await get_tree().create_timer(0.3).timeout
	get_tree().quit()
	
