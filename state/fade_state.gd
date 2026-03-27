extends Control

@onready var blackout: ColorRect = $blackout
const FADE_IN: float = .3
const FADE_OUT: float = .3

signal screen_black

func fade() -> void:
	var tween :Tween= get_tree().create_tween()
	tween.tween_property(blackout, "modulate:a", 1, FADE_OUT)\
	.set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(screen_black.emit)
	tween.tween_property(blackout, "modulate:a", 0, FADE_IN)\
	.set_trans(Tween.TRANS_QUAD)
