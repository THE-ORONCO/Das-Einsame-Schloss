class_name Interactible
extends Area3D

var interactable := false
var _player: CharacterBody3D = null
signal interacted
signal player_interacted(player: CharacterBody3D)

func _on_body_entered(body: Node3D) -> void:
	interactable = true
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
