extends CanvasLayer

@onready var pause_menu = $PauseMenu
@onready var options_menu = $Options
@onready var resume_button = $PauseMenu/VBoxContainer/continue
@onready var audio_start: AudioStreamPlayer = $Audio/AudioStart

var is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	options_menu.close()
	_connect_ui_sounds(self)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().current_scene.name == "main_menu":
			return
		toggle_pause()
		
func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
	if is_paused:
		pause_menu.show()
		resume_button.grab_focus()
	else:
		pause_menu.hide()
		options_menu.close()


func _on_settings_pressed() -> void:
	options_menu.open()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_main_menu_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://scenes/Menus/main_menu.tscn")


func _on_continue_pressed() -> void:
	toggle_pause()
	
func _connect_ui_sounds(node: Node) -> void:
	for child in node.get_children():
		if child is Button:
			if not child.focus_entered.is_connected(AudioManager.play_ui_focus):
				child.focus_entered.connect(AudioManager.play_ui_focus)
			if not child.mouse_entered.is_connected(AudioManager.play_ui_focus):
				child.mouse_entered.connect(AudioManager.play_ui_focus)
			if not child.pressed.is_connected(AudioManager.play_ui_click):
				child.pressed.connect(AudioManager.play_ui_click)
		_connect_ui_sounds(child)
	
