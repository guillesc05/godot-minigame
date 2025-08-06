extends Node2D
@onready var statue = $".."
@onready var sprite:AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var oreSpawnPos = $"../oreSpawnPos"
@onready var oreRef = "res://scenes/mountain_relic.tscn"

@onready var shakeAudio:AudioStreamPlayer2D = $"../shakeAudio"
@onready var throwUpAudio:AudioStreamPlayer2D = $"../throwUpAudio"

const THROW_FORCE:float = 200

const ANIM_TIME:float = 3
const SHAKE_INTENSITY:int = 2

var used:bool = false

func _ready() -> void:
	setOre(oreRef)

#oreToSet: direccion de la escena a instanciar
func setOre(oreToSet:String):
	oreRef = load(oreToSet)
	
func hitByDagger():
	if used: return
	shakeAudio.play()
	get_viewport().get_camera_2d().shakeCam(SHAKE_INTENSITY, ANIM_TIME)
	await get_tree().create_timer(ANIM_TIME).timeout
	throwUpAudio.play()
	instantiateOre()
func instantiateOre():
	#instantiate
	var ore = oreRef.instantiate()
	#make child of the scene
	statue.add_sibling(ore)
	ore.position = oreSpawnPos.position + statue.position
	#throw at statue dir
	var dir:Vector2
	
	if statue.scale.x >0:
		dir = Vector2(-1,0)
	else: dir = Vector2(1,0)
	ore.apply_impulse(dir*THROW_FORCE)
	
	
	sprite.animation = "mouth-opened"
	used = true
	
	statue.launchStatueEvent()
	
