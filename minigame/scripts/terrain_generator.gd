extends TileMapLayer

@onready var statueRef = preload("res://scenes/statue.tscn")

@onready var mountain_relic = "res://scenes/mountain_relic.tscn"
@onready var ocean_relic = "res://scenes/ocean_relic.tscn"

var rng = RandomNumberGenerator.new()

#genera en $ores las posiciones donde se deberian encontrar las menas, crea el objeto en la escena y emite el objeto por signal
func _ready() -> void:
	generate_terrain()
		

func generate_terrain()->void:
	
	generateMountain()
	generateOcean()
	

func generateMountain():
	var noise = FastNoiseLite.new()
	noise.frequency = 1
	var rnd_seed = rng.randi_range(0, 10000)
	#recorrido en las x para generar
	for i in range(0, Constants.MOUNTAIN_WIDTH):
		var value:float = float(i) / (Constants.MOUNTAIN_WIDTH)
		var rad = lerp(0.0, PI/2, value)
		var height =round(sin(rad) * Constants.MAX_TERRAIN_HEIGHT)
		
		var heightNoise = round(noise.get_noise_1d(rnd_seed + i) * 1.5)
		height += heightNoise
		
		set_cell(Vector2i(i + Constants.CANNON_BASE_WIDTH, -height), 0, Vector2i(1,0))
		for j in range(-4, height):
			set_cell(Vector2i(i + Constants.CANNON_BASE_WIDTH, -j), 0, Vector2i(1,1))
		#mountain statue
	var mountainStatue = statueRef.instantiate()
	mountainStatue.get_node("ThrowOreComponent").setOre(mountain_relic)
	add_sibling.call_deferred(mountainStatue)
	mountainStatue.position = Vector2(Constants.MOUNTAIN_WIDTH* 8, -Constants.MAX_TERRAIN_HEIGHT* 8 - 30)
	
func generateOcean():
	var noise = FastNoiseLite.new()
	noise.frequency = 1
	var rnd_seed = rng.randi_range(0, 10000)
	#recorrido en las x para generar
	for i in range(0, Constants.MOUNTAIN_WIDTH):
		var value:float = float(i) / (Constants.MOUNTAIN_WIDTH)
		var rad = lerp(0.0, PI/2, value)
		var height =round(sin(rad) * Constants.MAX_TERRAIN_HEIGHT)
		
		var heightNoise = round(noise.get_noise_1d(rnd_seed + i) * 1.5)
		height += heightNoise
		
		set_cell(Vector2i(-i - Constants.CANNON_BASE_WIDTH, height), 0, Vector2i(1,0))
		for j in range(height+1, 600):
			set_cell(Vector2i(-i - Constants.CANNON_BASE_WIDTH, j), 0, Vector2i(1,1))
		#mountain statue
	var oceanStatue = statueRef.instantiate()
	oceanStatue.get_node("ThrowOreComponent").setOre(ocean_relic)
	add_sibling.call_deferred(oceanStatue)
	oceanStatue.position = Vector2(-Constants.MOUNTAIN_WIDTH* Constants.TILE_SIZE, Constants.MAX_TERRAIN_HEIGHT* Constants.TILE_SIZE - 30)
	oceanStatue.scale.x = -1
