extends Camera2D
@onready var player: CharacterBody2D = $"../Player"

var shakeStrength:float = 3.0

var isShaking:bool = false

var rng = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	position.x = player.position.x
	position.y = lerp(position.y, calculateCamHeight(), .03)
	if isShaking: offset = getRndOffset()
	
func shakeCam(intensity: float, time: float):
	if isShaking: return
	shakeStrength = intensity
	isShaking = true
	
	await get_tree().create_timer(time).timeout
	isShaking = false
	offset = Vector2.ZERO

func getRndOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStrength, shakeStrength), rng.randf_range(-shakeStrength, shakeStrength))

func calculateCamHeight()->float:
	var playerPosX:float = player.position.x
	var playerVelX:float = player.velocity.x
	var baseLimit = Constants.CANNON_BASE_WIDTH * Constants.TILE_SIZE
	
	
	#if player outside base
	if abs(playerPosX) > baseLimit && abs(playerPosX) <(Constants.MOUNTAIN_WIDTH-10)* Constants.TILE_SIZE:
		if playerVelX >0:
			return player.position.y -44
		else: if playerVelX <0:
			return player.position.y + 33

	return player.position.y -44
