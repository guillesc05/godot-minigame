extends TileMapLayer



const MAX_TERRAIN_HEIGHT: int = 120
const MOUNTAIN_WIDTH: int = 200
const CANNON_BASE_WIDTH = 10
var rng = RandomNumberGenerator.new()

#genera en $ores las posiciones donde se deberian encontrar las menas, crea el objeto en la escena y emite el objeto por signal
func _ready() -> void:
	generate_terrain()
		

func generate_terrain()->void:
	for k in range(-CANNON_BASE_WIDTH, CANNON_BASE_WIDTH):
		set_cell(Vector2i(k, 0), 0, Vector2i(1,0))
		for k2 in 4:
			set_cell(Vector2i(k, k2+ 1), 0, Vector2i(1,1))
	
	generateMountain()
	

func generateMountain():
	var noise = FastNoiseLite.new()
	noise.frequency = 1
	var rnd_seed = rng.randi_range(0, 10000)
	#recorrido en las x para generar
	for i in range(0, MOUNTAIN_WIDTH):
		var value:float = float(i) / (MOUNTAIN_WIDTH)
		var rad = lerp(0.0, PI/2, value)
		var height =round(sin(rad) * MAX_TERRAIN_HEIGHT)
		
		var heightNoise = round(noise.get_noise_1d(rnd_seed + i) * 1.5)
		height += heightNoise
		
		set_cell(Vector2i(i + CANNON_BASE_WIDTH, -height), 0, Vector2i(1,0))
		for j in (height):
			set_cell(Vector2i(i + CANNON_BASE_WIDTH, -j), 0, Vector2i(1,1))
	
