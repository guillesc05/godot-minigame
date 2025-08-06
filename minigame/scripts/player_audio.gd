extends AnimatedSprite2D

@onready var audio:AudioStreamPlayer2D = $"../walkAudio"
@onready var player:CharacterBody2D = $".."

func _on_animation_looped() -> void:
	if player.is_on_floor() && absf(player.velocity.x) > 0:
		audio.play()



func _on_animation_changed() -> void:
	if player.is_on_floor() && absf(player.velocity.x) > 0:
		audio.play()
