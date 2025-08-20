extends Sprite2D

@onready var audio:AudioStreamPlayer2D = $shot_audio

func _ready() -> void:
	SceneInfo.game_won.connect(show_shot)

func show_shot():
	await get_tree().create_timer(3.5).timeout
	visible = true
	get_viewport().get_camera_2d().shakeCam(2, 2)
	audio.play()
