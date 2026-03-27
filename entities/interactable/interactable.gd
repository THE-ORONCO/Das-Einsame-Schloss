class_name Interactible
extends Area3D

var interactable := false
var _player: CharacterBody3D = null
var was_actiated_later: bool:
	get:
		var later = SproutyDialogs.Variables.get_variable("activate_objects")
		return later != null && later == true
signal interacted
signal player_interacted(player: CharacterBody3D)
const SPOOK_POINT = preload("uid://b1yawdyvaadun")


@export
var activate_later: bool = false

func _on_body_entered(body: Node3D) -> void:
	interactable = true if !activate_later else was_actiated_later
	_player = body
	print("Entered")

func _on_body_exited(_body: Node3D) -> void:
	interactable = false
	_player = null
	print("Exited")

func _input(event: InputEvent) -> void:
	if interactable and event.is_action_pressed("player_interact"):
		print("interaction")		
		interacted.emit()
		player_interacted.emit(_player)

var haunted: bool = false
func _physics_process(delta: float) -> void:
	if activate_later && was_actiated_later && not haunted:
		var haunt: SpookPoint = SPOOK_POINT.instantiate()
		self.add_child(haunt)
		haunt.global_position = self.global_position
		haunted = true
