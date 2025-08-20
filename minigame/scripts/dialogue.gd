extends Node2D

@onready var label:Label = $Label
@onready var timer:Timer = $Timer
@onready var sound:AudioStreamPlayer2D = $dialogue_sound

const CHAR_TIME = .1
const AWAIT_TIME = 1.3

var dialogues = [
"My child...", 
"A horrible monster\nis falling\nfrom the skies.",
"And if it were to\ncollide, we will all\nperish.",
"Look up at the sky.\nCan you see it?",
"You must harvest\nthe two sacred relics\nguarded by golems\nand throw them\ndown the cliff.",
"With that,\nwe may be able to\nstop our horrible\ndestiny!",
"Please, take this\nand save us all!"
]

func _ready() -> void:
	await displayText()
	label.text = ""
	SceneInfo.end_dialogue()

func displayText():
	for j in dialogues.size():
		label.text = ""
		var text:String = dialogues[j]
		for i in text.length():
			timer.start(CHAR_TIME)
			label.text += text[i]
			if text[i] != " ": sound.play()
			await timer.timeout
		timer.start(AWAIT_TIME)
		await timer.timeout
