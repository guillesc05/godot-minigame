extends Area2D

@onready var topPlayerNode = $".."
@onready var eKeyRef = preload("res://scenes/e_key.tscn")
@onready var pickUpAudio:AudioStreamPlayer2D = $"../pickUpAudio"
@onready var throwAudio:AudioStreamPlayer2D = $"../throwAudio"

var lastObjectToGrab: Array = []
var objectBeingGrabbed: RigidBody2D = null
var formerObjectBeingGrabbedParent = null

var throwDirection: Vector2 = Vector2(2,-1)

var e_key = null

var THROW_FORCE = 200

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("grabbableComponent") && body != objectBeingGrabbed:
		lastObjectToGrab.push_front(body)
		if objectBeingGrabbed == null:
			if e_key ==null:
				e_key = eKeyRef.instantiate()
				topPlayerNode.add_sibling(e_key)
			e_key.setObjectToFollow(lastObjectToGrab[0])

func _on_body_exited(body: Node2D) -> void:
	if body.has_node("grabbableComponent"):
		lastObjectToGrab.erase(body)
		if lastObjectToGrab.size() >0 && lastObjectToGrab[0] != null:
			e_key.setObjectToFollow(lastObjectToGrab[0])
		else: if e_key != null: 
			e_key.queue_free()
		
func grab():
	objectBeingGrabbed = lastObjectToGrab[0]
	formerObjectBeingGrabbedParent = objectBeingGrabbed.get_parent()
	objectBeingGrabbed.freeze = true
	objectBeingGrabbed.reparent(topPlayerNode)
	objectBeingGrabbed.position = Vector2(0, -15)
	
	var movement = topPlayerNode.get_node("movement")
	
	movement.setWalkAnimation("grabbing-walk")
	movement.setIdleAnimation("grabbing-idle")
	pickUpAudio.play()
		
	
func ungrab():
	objectBeingGrabbed.reparent(formerObjectBeingGrabbedParent)
	objectBeingGrabbed.freeze = false
	objectBeingGrabbed.apply_impulse(throwDirection* THROW_FORCE)
	objectBeingGrabbed = null
	formerObjectBeingGrabbedParent = null
	
	var movement = topPlayerNode.get_node("movement")
	movement.setWalkAnimation("walk")
	movement.setIdleAnimation("idle")
	throwAudio.play()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("movement-left"):
		throwDirection = Vector2(-2,-1).normalized()
	if Input.is_action_just_pressed("movement-right"):
		throwDirection = Vector2(2,-1).normalized()
	
	if Input.is_action_just_pressed("grab") && lastObjectToGrab.size() >0 && objectBeingGrabbed == null:
		grab()
		
	else: if Input.is_action_just_pressed("grab") && objectBeingGrabbed != null:
		ungrab()
