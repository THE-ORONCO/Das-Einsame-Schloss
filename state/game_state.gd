extends Node


enum {
	WALKING,
	DIALOGUE,
	LOCK_PICK,
}

var current_state = WALKING

func walk() -> void: current_state = WALKING
func talk() -> void: current_state = DIALOGUE
func pick() -> void: current_state = LOCK_PICK
func set_state(game_state) -> void: current_state = game_state
