extends Area2D

@onready var topPlayerNode = $".."

var lastObjectToGrab: Array = []
var objectBeingGrabbed: RigidBody2D = null
var formerObjectBeingGrabbedParent = null

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.has_node("grabbableComponent") && body != objectBeingGrabbed:
		lastObjectToGrab.push_front(body)

func _on_body_exited(body: Node2D) -> void:
	if body.has_node("grabbableComponent"):
		lastObjectToGrab.erase(body)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("grab") && lastObjectToGrab.size() >0 && objectBeingGrabbed == null:
		objectBeingGrabbed = lastObjectToGrab[0]
		formerObjectBeingGrabbedParent = objectBeingGrabbed.get_parent()
		objectBeingGrabbed.freeze = true
		objectBeingGrabbed.reparent(topPlayerNode)
		objectBeingGrabbed.position = topPlayerNode.position
	else: if Input.is_action_just_pressed("grab") && objectBeingGrabbed != null:
		objectBeingGrabbed.reparent(formerObjectBeingGrabbedParent)
		objectBeingGrabbed.freeze = false
		objectBeingGrabbed.apply_impulse(Vector2(1,0))
		objectBeingGrabbed = null
		formerObjectBeingGrabbedParent = null
