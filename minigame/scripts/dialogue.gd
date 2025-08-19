extends Node2D

@onready var label:Label = $Label
@onready var timer:Timer = $Timer

const CHAR_TIME = .1
const AWAIT_TIME = 1

var dialogues = [
"My child...", 
"You have to rush... \nor else we will all die",
"Can't you see the\ncalamity that is \napproaching?"
]

func _ready() -> void:
	displayText()

func displayText():
	for j in dialogues.size():
		label.text = ""
		var text:String = dialogues[j]
		for i in text.length():
			timer.start(CHAR_TIME)
			label.text += text[i]
			await timer.timeout
		timer.start(AWAIT_TIME)
		await timer.timeout
