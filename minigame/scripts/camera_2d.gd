extends Camera2D
@onready var player: CharacterBody2D = $"../Player"

var shakeStrength:float = 3.0

var isShaking:bool = false

var rng = RandomNumberGenerator.new()

const OFFSET = 38

var camYOffset = -OFFSET

func _process(delta: float) -> void:
	position.x = player.position.x
	position.y = lerp(position.y, player.position.y + camYOffset, 0.01)
	if isShaking: offset = getRndOffset()

func moveCamUp(): camYOffset = -OFFSET
func moveCamDown(): camYOffset = OFFSET
	
func shakeCam(intensity: float, time: float):
	if isShaking: return
	shakeStrength = intensity
	isShaking = true
	
	await get_tree().create_timer(time).timeout
	isShaking = false
	offset = Vector2.ZERO

func getRndOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStrength, shakeStrength), rng.randf_range(-shakeStrength, shakeStrength))
