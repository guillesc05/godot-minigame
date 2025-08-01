extends Sprite2D

func _process(delta: float) -> void:
	material.set_shader_parameter("mouse_position", get_local_mouse_position())
