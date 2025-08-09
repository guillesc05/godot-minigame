extends Area2D
@onready var explosionAudio:AudioStreamPlayer2D = $"../wellExplosionAudio"
@onready var particles : CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	particles.emitting = false

func _on_body_entered(body: Node2D) -> void:
	#damos por sentado que lo que entra es siempre una reliquia
	var color:Color = body.get_node("Sprite2D").material.get_shader_parameter("color")
	SceneInfo.relic_delivered(color)
	explosionAudio.play()
	particles.emitting = true
	get_viewport().get_camera_2d().shakeCam(1, 1)
