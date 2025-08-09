extends Node2D
@onready var dagger = preload("res://scenes/dagger.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneInfo.cannon_filled.connect(createDagger)
	var a
	createDagger(a)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func createDagger(color):
	var daggerInstanted = dagger.instantiate()
	add_child(daggerInstanted)
	daggerInstanted.position = Vector2(0, -10)
