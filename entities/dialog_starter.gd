@tool
class_name DialogStarter
extends Node

@export
var interaction_point: Interactible:
	set(val):
		interaction_point = val
		update_configuration_warnings()

@export
var dialogue: DialogPlayer:
	set(val):
		dialogue = val
		update_configuration_warnings()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint(): return
	interaction_point.interacted.connect(dialogue.start, CONNECT_ONE_SHOT)


func _get_configuration_warnings() -> PackedStringArray:
	var warn: PackedStringArray = []
	if interaction_point == null: warn.append("you should add an Interactible")
	if dialogue == null: warn.append("you should add a DialogPlayer")
	return warn
