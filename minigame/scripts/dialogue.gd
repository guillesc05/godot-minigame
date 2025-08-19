extends Node2D

@onready var label:Label = $Label
@onready var timer:Timer = $Timer
@onready var sound:AudioStreamPlayer2D = $dialogue_sound

const CHAR_TIME = .1
const AWAIT_TIME = 1.3

var dialogues = [
"My child...", 
"Can't you see the\ncalamity that is \napproaching?",
"You have to rush... \nor else we will all die",
"Look up at the sky\nand you will understand.\nIt is horrible",
"Harvest\nthe two sacred relics\nguarded by golems",
"and throw them\ndown the cliff",
"That will charge\nthe magic cannon and stop\nthis horrible threat",
"Please, take this\nand save us all!"
]

func _ready() -> void:
	await displayText()
	label.text = ""
	SceneInfo.dialogue_ended.emit()

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
