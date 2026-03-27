@tool
extends Node3D

@export
var locked: bool = false:
	set(val):
		locked = val
		update_configuration_warnings()
var _target: Marker3D
var _player: DialogPlayer

@export var sound_interact: AudioStream

@onready var interactible: Interactible = %Interactible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint(): return
	_target = get_children().filter(func(c):return c is Marker3D)[0]
	if locked:
		_player = get_children().filter(func(c):return c is DialogPlayer)[0]

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	if !get_children().any(func(c):return c is Marker3D): 
		warnings.append("Add a Marker3D Node as child to define the target of this door")
	if locked && !get_children().any(func(c):return c is DialogPlayer):
		warnings.append("If a door is locked it needs a DialogPlayer as its child to trigger the dialog and unlock the door after")
	return warnings

func _on_player_interaction(player: CharacterBody3D) -> void:
	if _player != null && _player.is_running(): return
	if locked:
		_player.start()
		_player.dialog_ended.connect(func():self.locked = false)
		return
	
	AudioManager.play_sfx_global(sound_interact)
	FadeState.screen_black.connect(func():
		player.global_position = _target.global_position,
		CONNECT_ONE_SHOT)
	FadeState.fade()

func _on_editor_state_changed() -> void:
	update_configuration_warnings()
