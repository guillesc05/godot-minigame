extends Node2D
@onready var oreMaterial: ShaderMaterial = $"../Sprite2D".material

func getColor()->Color:
	return oreMaterial.get_shader_parameter("color")

func setColor(color:Color)->void:
	oreMaterial.set_shader_parameter("color", color)
