extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var ui_sfx_player: AudioStreamPlayer = $UISFXPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer

var click_sound = preload("res://entities/audio/Menu Selection Click.wav")
var hover_sound = preload("res://entities/audio/Menu Selection Click.wav")

var low_ambient = preload("res://scenes/Menus/main_menu/low-ambient.mp3")
var bg_music = preload("res://audio/music/Background_track.mp3")

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

func play_gb_music() -> void:
	music_player.stream = bg_music
	music_player.play()

func stop_bg_music() -> void:
	music_player.stop()

func play_sfx_global(audiostream: AudioStream) -> void:
	sfx_player.stream = audiostream
	sfx_player.play()
