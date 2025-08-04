extends Area2D

@onready var topPlayerNode = $".."

var lastObjectToGrab: Array = []
var objectBeingGrabbed: RigidBody2D = null
var formerObjectBeingGrabbedParent = null

var throwDirection: Vector2 = Vector2(2,-1)

var THROW_FORCE = 200

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.has_node("grabbableComponent") && body != objectBeingGrabbed:
		lastObjectToGrab.push_front(body)

func _on_body_exited(body: Node2D) -> void:
	if body.has_node("grabbableComponent"):
		lastObjectToGrab.erase(body)
		
func grab():
	objectBeingGrabbed = lastObjectToGrab[0]
	formerObjectBeingGrabbedParent = objectBeingGrabbed.get_parent()
	objectBeingGrabbed.freeze = true
	objectBeingGrabbed.reparent(topPlayerNode)
	objectBeingGrabbed.position = Vector2(0, -15)
	
	topPlayerNode.setWalkAnimation("grabbing-walk")
	topPlayerNode.setIdleAnimation("grabbing-idle")
	
func ungrab():
	objectBeingGrabbed.reparent(formerObjectBeingGrabbedParent)
	objectBeingGrabbed.freeze = false
	objectBeingGrabbed.apply_impulse(throwDirection* THROW_FORCE)
	objectBeingGrabbed = null
	formerObjectBeingGrabbedParent = null
	topPlayerNode.setWalkAnimation("walk")
	topPlayerNode.setIdleAnimation("idle")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("movement-left"):
		throwDirection = Vector2(-2,-1).normalized()
	if Input.is_action_just_pressed("movement-right"):
		throwDirection = Vector2(2,-1).normalized()
	
	if Input.is_action_just_pressed("grab") && lastObjectToGrab.size() >0 && objectBeingGrabbed == null:
		grab()
		
	else: if Input.is_action_just_pressed("grab") && objectBeingGrabbed != null:
		ungrab()
