extends RigidBody2D

var used:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if(!used):
		print(body.name)
		if body.has_node("ThrowOreComponent"): 
			body.get_node("ThrowOreComponent").instantiateOre()
			freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
			freeze = true
			$grabbableComponent.queue_free()
			used = true
			
			var rot: float = 0
			if body.scale.x < 0: rot = 180
			
			rotation_degrees = rot
			
			var cam = get_viewport().get_camera_2d()
