extends Sprite2D
@onready var camera: Camera2D = $"../../Camera2D"

@onready var falling_audio:AudioStreamPlayer2D = $falling_audio

const MIN_VELOCITY:float = -.5
const MAX_VELOCITY:float = -3000

var currVelY = MIN_VELOCITY
var tween:Tween
var audioTween:Tween

func _ready() -> void:
	SceneInfo.dialogue_ended.connect(on_dialogue_end)
	SceneInfo.game_won.connect(on_game_won)

func _process(delta: float) -> void:
	var yPos: float = material.get_shader_parameter("offsetY")
	material.set_shader_parameter("offsetX",camera.position.x * .5)
	material.set_shader_parameter("offsetY",yPos + currVelY*delta)
	
func on_game_won():
	await get_tree().create_timer(3.5).timeout
	tween.pause()
	audioTween.pause()
	falling_audio.stop()
	currVelY = 0

func on_dialogue_end():
	falling_audio.play()
	audioTween = create_tween().set_trans(Tween.TRANS_EXPO)
	tween = create_tween().set_trans(Tween.TRANS_EXPO)
	audioTween.tween_property(falling_audio, "volume_db", 0.0, SceneInfo.TIME_UNTIL_LOST)
	tween.tween_property(self,"currVelY", MAX_VELOCITY, SceneInfo.TIME_UNTIL_LOST)
