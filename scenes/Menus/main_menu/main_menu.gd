extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var start_button: Button = $MainButtons/start
@onready var credits: Control = $Credits
@onready var back: Button = $Credits/VBoxContainer/Back


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	credits.visible = false
	start_button.grab_focus()
	UiManager._connect_ui_sounds(self)
	AudioManager.play_ambient()
	GameState.main_menu_opened.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	#UiManager.playStartSFX()
	AudioManager.play_gb_music()
	get_tree().change_scene_to_file("res://scenes/castle.tscn")


func _on_options_pressed() -> void:
	#AudioManager.play_ui_click()
	UiManager.options_menu.open()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	credits.visible = true
	main_buttons.visible = false
	back.grab_focus()


func _on_credits_back_pressed() -> void:
	credits.visible = false	
	main_buttons.visible = true
	start_button.grab_focus()
