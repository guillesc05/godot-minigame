extends Sprite2D
@onready var camera: Camera2D = $"../../Camera2D"
@onready var me = $"."
func _process(delta: float) -> void:
	var yPos: float = material.get_shader_parameter("offset").y
	material.set_shader_parameter("offset",Vector2(camera.position.x * .5, yPos+5*delta))
	pass
