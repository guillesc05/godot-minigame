extends Node2D

func _ready() -> void:
	SceneInfo.game_lost.connect(game_lost)
	SceneInfo.game_won.connect(game_won)

func game_won():
	await get_tree().create_timer(6).timeout
	get_tree().change_scene_to_file("res://scenes/won_screen.tscn")

func game_lost():
	get_tree().change_scene_to_file("res://scenes/lost_screen.tscn")
