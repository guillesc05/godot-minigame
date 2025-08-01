extends Node2D

@onready var oreArray = []

func _pushOre(ore)-> void :
	oreArray.push_back(ore)
