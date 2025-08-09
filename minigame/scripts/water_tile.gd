extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mat:ShaderMaterial = material;
	var progress = mat.get_shader_parameter("progress")
	progress+=delta
	if progress > 1: progress -=1
	
	mat.set_shader_parameter("progress", progress)
	pass
