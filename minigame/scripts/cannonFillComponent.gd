extends TileMapLayer
@onready var shaderMat:ShaderMaterial = material


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneInfo.cannon_filled.connect(fill)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fill(color:Color):
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	var tween2 = create_tween().set_trans(Tween.TRANS_SPRING)
	var progress = shaderMat.get_shader_parameter("progress")
	tween.tween_property(self.material, "shader_parameter/progress", progress+ 0.5, 1)
	
	tween2.tween_property(self.material, "shader_parameter/wave_1_color", color, 1)
