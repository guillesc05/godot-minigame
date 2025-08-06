extends RigidBody2D
@onready var spriteMat: ShaderMaterial = $Sprite2D.material
@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var timer:Timer = $Timer
@onready var heartBeat:AudioStreamPlayer2D = $beatAudio

const LONG_BEAT_TIME = .7
const SHORT_BEAT_TIME = 0.3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(LONG_BEAT_TIME)
	while true:
		heartBeat.play()
		await timer.timeout
		heartBeat.play()
		timer.start(SHORT_BEAT_TIME)
		await timer.timeout
		timer.start(LONG_BEAT_TIME)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
