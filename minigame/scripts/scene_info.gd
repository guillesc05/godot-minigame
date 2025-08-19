extends Node2D

const RELICS_REQUIRED:int = 2

var relic_count:int =0

signal cannon_filled;
signal game_won;
signal instantiate_dagger;

signal dialogue_ended;

func relic_delivered(color:Color):
	relic_count+=1
	cannon_filled.emit(color)
	if relic_count == RELICS_REQUIRED:
		game_won;
	else: instantiate_dagger.emit()
