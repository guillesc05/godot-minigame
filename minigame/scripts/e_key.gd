extends Sprite2D

var objectToFollow = null
var DISTANCE_FROM_OBJECT:float = -8.0

func setObjectToFollow(obj):
	objectToFollow = obj

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if objectToFollow != null:
		position = objectToFollow.position + Vector2(0.0, DISTANCE_FROM_OBJECT)
