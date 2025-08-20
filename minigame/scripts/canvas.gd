extends Sprite2D
@onready var camera: Camera2D = $"../../Camera2D"
@onready var me = $"."

const MIN_VELOCITY:float = -.5
const MAX_VELOCITY:float = -4000

var currVelY = MIN_VELOCITY

func _ready() -> void:
	SceneInfo.dialogue_ended.connect(on_dialogue_end)

func _process(delta: float) -> void:
	var yPos: float = material.get_shader_parameter("offsetY")
	material.set_shader_parameter("offsetX",camera.position.x * .5)
	material.set_shader_parameter("offsetY",yPos + currVelY*delta)
	
	

func on_dialogue_end():
	var tween = create_tween().set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self,"currVelY", MAX_VELOCITY, SceneInfo.TIME_UNTIL_LOST)
