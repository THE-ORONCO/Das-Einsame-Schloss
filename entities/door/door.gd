@tool
extends Node3D

var open: bool = false
var _target: Marker3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint(): return
	_target = get_children().filter(func(c):return c is Marker3D)[0]

func _get_configuration_warnings() -> PackedStringArray:
	if !get_children().any(func(c):return c is Marker3D): return ["Add a Marker3D Node as child to define the target of this door"]
	return []


func _on_player_interaction(player: CharacterBody3D) -> void:
	player.global_position = _target.global_position


func _on_editor_state_changed() -> void:
	update_configuration_warnings()
