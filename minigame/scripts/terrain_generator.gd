extends TileMapLayer
@onready var ores: TileMapLayer = $ores
@onready var scene = preload("res://scenes/color_extract.tscn")

const NUM_ORES :int = 6
const MAX_TERRAIN_HEIGHT: int = 8
const MIN_TERRAIN_HEIGHT: int = 2
const TERRAIN_WIDTH: int = 100
var rng = RandomNumberGenerator.new()

#genera en $ores las posiciones donde se deberian encontrar las menas, crea el objeto en la escena y emite el objeto por signal
func _ready() -> void:
	generate_terrain()
	generate_ores()
		

func generate_terrain()->void:
	var noise = FastNoiseLite.new()
	var rnd_seed = rng.randi_range(0, 10000)
	for i in range(-TERRAIN_WIDTH/2, TERRAIN_WIDTH/2):
		var smooth_factor: float = absf(i)/(TERRAIN_WIDTH/2)
		var value = (noise.get_noise_1d((rnd_seed+ i) * 10)+ 1)/2 * (smooth_factor)
		var height = round(lerp(MIN_TERRAIN_HEIGHT, MAX_TERRAIN_HEIGHT, value))
		set_cell(Vector2i(i, -height), 0, Vector2i(1,0))
		for j in height:
			set_cell(Vector2i(i, -j), 0, Vector2i(1,1))

func generate_ores()->void:
	var grass_cells = get_used_cells_by_id(0, Vector2i(1,0))
	var x_cells_occupied: Array = []
	for i in NUM_ORES-1:
		#generate ores
		var ore = scene.instantiate()
		add_child(ore)
		rng.randomize()
		var num = rng.randi_range(0, grass_cells.size()-1)
		var posX = grass_cells[num].x
		while x_cells_occupied.has(posX):
			num = rng.randi_range(0, grass_cells.size()-1)
			posX = grass_cells[num].x
		
		#place tile in ores
		ores.set_cell(Vector2(grass_cells[num].x, grass_cells[num].y + 1), 1, Vector2(0,0))
		ore.position.x = posX * 8 + 8/2
		ore.position.y = grass_cells[num].y * 8 + 8 + 8/2
		
		#anyadir a la lista de celdas imposibles la posicion del mineral, y las adyacentes
		x_cells_occupied.push_back(posX) 
		x_cells_occupied.push_back(posX + 1) 
		x_cells_occupied.push_back(posX - 1) 
		
		#color aleatorio del material
		var color:Color = ore.get_node("color").getColor()
		color.h = rng.randf()
		ore.get_node("color").setColor(color)
		
