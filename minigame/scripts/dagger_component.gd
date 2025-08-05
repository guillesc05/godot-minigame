extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	print(body.name)
	if body.has_node("ThrowOreComponent"): body.get_node("ThrowOreComponent").instantiateOre()
