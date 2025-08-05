extends Camera2D
@onready var player: CharacterBody2D = $"../Player"

const OFFSET = 38

var camYOffset = -OFFSET

func _process(delta: float) -> void:
	position.x = player.position.x
	position.y = lerp(position.y, player.position.y + camYOffset, 0.01)
