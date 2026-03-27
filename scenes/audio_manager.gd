extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var ui_sfx_player: AudioStreamPlayer = $UISFXPlayer

var click_sound = preload("res://entities/audio/Menu Selection Click.wav")
var hover_sound = preload("res://entities/audio/Menu Selection Click.wav")

var low_ambient = preload("res://scenes/Menus/main_menu/low-ambient.mp3")

func play_ui_click() -> void:
	ui_sfx_player.stream = click_sound
	ui_sfx_player.play()

func play_ui_focus() -> void:
	ui_sfx_player.stream = hover_sound
	ui_sfx_player.play()

func play_ambient() -> void:
	music_player.stream = low_ambient
	music_player.play()

func stop_ambient() -> void:
	music_player.stop()
