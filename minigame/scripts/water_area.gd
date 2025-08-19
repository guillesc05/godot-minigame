extends Area2D
@onready var water_splash = preload("res://scenes/splash_particles.tscn")
@onready var splashAudio: AudioStreamPlayer2D = $"../relic_counter/splash"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("set_player_linear_damp"): body.set_player_linear_damp(15)
	
	var splash:Node2D = water_splash.instantiate()
	add_child(splash)
	splash.position = body.position
	splash.get_node("CPUParticles2D").emitting = true
	splashAudio.play()
	
	await get_tree().create_timer(1).timeout
	splash.queue_free()


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("set_player_linear_damp"): body.set_player_linear_damp(0)
