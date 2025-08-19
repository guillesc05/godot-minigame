extends CharacterBody2D

@onready var animator:AnimatedSprite2D = $spriteAnim
@onready var jumpAudio:AudioStreamPlayer2D = $jumpAudio

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
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("movement-jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY + 3*  linear_damp
		jumpAudio.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("movement-left", "movement-right")
	if direction:
		velocity.x = direction * (SPEED - linear_damp)
		animator.play(walkAnimation)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animator.play(idleAnimation)

	move_and_slide()
