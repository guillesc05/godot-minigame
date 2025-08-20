extends Node2D
@onready var dagger = preload("res://scenes/dagger.tscn")
@onready var fanfare:AudioStreamPlayer2D = $fanfare

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneInfo.instantiate_dagger.connect(createDagger)
	SceneInfo.dialogue_ended.connect(createDagger)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func createDagger():
	fanfare.play()
	var daggerInstanced = dagger.instantiate()
	add_child(daggerInstanced)
	daggerInstanced.position = Vector2(-35, -100)
	daggerInstanced.freeze = true
	var tween = get_tree().create_tween()
	tween.tween_property(daggerInstanced, "position", Vector2(-35, -10), 3)
	await tween.finished
	daggerInstanced.freeze = false
