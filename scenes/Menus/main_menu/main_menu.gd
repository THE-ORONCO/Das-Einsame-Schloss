extends Control

@onready var main_buttons: VBoxContainer = $MainButtons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/castle.tscn")


func _on_options_pressed() -> void:
	UiManager.options_menu.open()

func _on_quit_pressed() -> void:
	get_tree().quit()
