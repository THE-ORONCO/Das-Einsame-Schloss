extends CanvasLayer

@onready var pause_menu = $PauseMenu
@onready var options_menu = $Options
@onready var resume_button = $PauseMenu/VBoxContainer/continue

var is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	options_menu.close()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().current_scene.name == "main_menu":
			return
		toggle_pause()
		
func toggle_pause() -> void:
	is_paused = !is_paused
	# get_tree().paused = is_paused
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

func open_settings(vbox: VBoxContainer) -> void:
	pass
