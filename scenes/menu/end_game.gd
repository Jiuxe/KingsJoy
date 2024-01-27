extends Control

var ranking = []

func _ready():
	pass
	
func pre_start(params):
	
	# ranking.append({"score": str(int(params.time_alive)), "player_name":params.player_name})
	ranking.append({"score":"1", "player_name":"JIUXE"})
	ranking.sort_custom(func(a, b): return a.score < b.score)
	
	if ranking.size() > 3:
		ranking.pop_back()
	
	var ranking_box = get_node("MarginContainer/Control/Ranking").get_children()
	get_node("MarginContainer/Control/Ranking/Cabecera/HBoxContainer/Nombre")
	for box in ranking_box:
		var score = box.get_node("HBoxContainer/Tiempo")
		var player_name = box.get_node("HBoxContainer/Nombre")
		
		if ranking.size() > box.get_index():
			score.text = ranking[box.get_index()].score
			player_name.text = ranking[box.get_index()].player_name
	
	save_ranking(ranking)
	
func save_ranking(ranking):
	verify_save_directory()
	var file = FileAccess.open("user://score_saves/save_game.dat", FileAccess.WRITE)	
	
	for player in ranking:
		print(file)
		file.store_string(str(player))
	

func verify_save_directory():
	var data_directory = DirAccess
	data_directory.open("user://")
	if !data_directory.dir_exists_absolute("score_saves"):
		data_directory.make_dir_absolute("score_saves")
	""""
	var file_directory = FileAccess.file_exists("user://score_saves/save_game.dat")
	if !file_directory:
		FileAccess.new()
		.new("user://score_saves/save_game.dat")
	"""

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
	
