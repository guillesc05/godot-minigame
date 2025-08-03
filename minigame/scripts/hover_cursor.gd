extends Area2D

@onready var cursorTexture: Sprite2D = $"../cursor"

func _ready() -> void:
	cursorTexture.visible = false

func _mouse_enter() -> void:
	print("lol")
	cursorTexture.visible = true
	
	
func _mouse_exit() -> void:
	print("exit")
	cursorTexture.visible = false
