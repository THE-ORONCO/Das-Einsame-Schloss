extends Panel

var previous_focus: Control
@onready var first_setting_element = $VBoxContainer/JumpscareButton
var iSeeYou = preload("res://scenes/Menus/main_menu/i-see-you.mp3")
# Reference to your back button
#@onready var back_button = $back


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func open() -> void:
	previous_focus = get_viewport().gui_get_focus_owner()	
	show()
	first_setting_element.call_deferred("grab_focus")
	
func close() -> void:
	hide()
	if previous_focus != null:
		previous_focus.grab_focus()


func _on_back_pressed() -> void:
	close()
	
func _input(event: InputEvent) -> void:
	# Check if the Settings Menu is currently open AND the "Back" button is pressed
	if visible and event.is_action_pressed("pause"):        
		# Tell Godot: "I handled this input, do not pass it to the Pause Menu or game!"
		get_viewport().set_input_as_handled()
		close()


func _on_jumpscare_button_pressed() -> void:
	AudioManager.play_sfx_global(iSeeYou)
