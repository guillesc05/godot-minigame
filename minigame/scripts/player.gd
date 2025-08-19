extends CharacterBody2D

@onready var movement = $movement

func _ready() -> void:
	movement.set_physics_process(false)
	SceneInfo.dialogue_ended.connect(enableMovement)

func enableMovement():
	movement.set_physics_process(true)
