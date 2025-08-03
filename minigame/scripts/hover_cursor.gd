extends Area2D

@onready var cursorTexture: Sprite2D = $"../cursor"
@onready var tilemap: TileMapLayer = $"../../buildings"
@onready var pos = $"../position_in_grid"

var cursorOnTexture: bool = false

func _ready() -> void:
	cursorOnTexture = false
	cursorTexture.visible = false

func _mouse_enter() -> void:
	print("lol")
	cursorOnTexture = true
	cursorTexture.visible = true
	
	
func _mouse_exit() -> void:
	print("exit")
	cursorOnTexture = false
	cursorTexture.visible = false

func _input(event: InputEvent) -> void:
	if cursorOnTexture and Input.is_action_just_pressed("click"):
		var pos:Vector2 = pos.getGridPos()
		tilemap.create_drill_at(pos - Vector2(0, 3))
