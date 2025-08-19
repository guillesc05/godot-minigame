extends Node2D
@onready var character_body:CharacterBody2D = $".."
@onready var animator:AnimatedSprite2D = $"../spriteAnim"
@onready var jumpAudio:AudioStreamPlayer2D = $"../jumpAudio"

const SPEED:float = 50
const JUMP_VELOCITY = -200.0
var linear_damp:float = 0

func set_player_linear_damp(num:float): linear_damp = num

var walkAnimation:String = "walk"
var idleAnimation:String = "idle"

func setWalkAnimation(anim:String):
	walkAnimation = anim
	
func setIdleAnimation(anim:String):
	idleAnimation = anim

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not character_body.is_on_floor():
		character_body.velocity += character_body.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("movement-jump") and character_body.is_on_floor():
		character_body.velocity.y = JUMP_VELOCITY + 3*  linear_damp
		jumpAudio.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("movement-left", "movement-right")
	if direction:
		character_body.velocity.x = direction * (SPEED - linear_damp)
		animator.play(walkAnimation)
	else:
		character_body.velocity.x = move_toward(character_body.velocity.x, 0, SPEED)
		animator.play(idleAnimation)

	character_body.move_and_slide()
