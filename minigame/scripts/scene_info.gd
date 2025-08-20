extends Node2D
@onready var lost_timer:Timer = $Timer

const RELICS_REQUIRED:int = 2
const TIME_UNTIL_LOST = 3

var relic_count:int =0

signal cannon_filled;
signal game_won;
signal game_lost;
signal instantiate_dagger;

signal dialogue_ended;

func end_dialogue() -> void:
	dialogue_ended.emit()
	lost_timer.start(TIME_UNTIL_LOST)
	await lost_timer.timeout
	game_won.emit()


func relic_delivered(color:Color):
	relic_count+=1
	cannon_filled.emit(color)
	if relic_count == RELICS_REQUIRED:
		lost_timer.paused = true
		game_won.emit();
	else: instantiate_dagger.emit()
