extends Area3D

var interactable := false

func _on_body_entered(body: Node3D) -> void:
	interactable = true
	print("Entered")

func _on_body_exited(body: Node3D) -> void:
	interactable = false
	print("Exited")

func _input(event: InputEvent) -> void:
	if interactable and event.is_action_pressed("player_interact"):
		print("interaction")
