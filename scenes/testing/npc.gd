extends Node3D


@onready var dialog_player: DialogPlayer = $DialogPlayer


func _on_interactible_interacted() -> void:
	dialog_player.start()
