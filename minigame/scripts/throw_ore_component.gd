extends Node2D
@onready var statue = $".."
@onready var sprite:AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var oreSpawnPos = $"../oreSpawnPos"
@onready var oreRef = "res://scenes/mountain_relic.tscn"

const THROW_FORCE:float = 200

var used:bool = false

func _ready() -> void:
	setOre(oreRef)

#oreToSet: direccion de la escena a instanciar
func setOre(oreToSet:String):
	oreRef = load(oreToSet)
	
func instantiateOre():
	if used: return
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
	
