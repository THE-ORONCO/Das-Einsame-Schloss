@tool
extends DialogBox

func _ready() -> void:
	GameState.main_menu_opened.connect(self.stop_dialog)

# -----------------------------------------------------------------------------
# This is a template for a custom dialog box with a default behavior.
# -----------------------------------------------------------------------------
## This script provides a basic implementation of a dialog box behavior.
## You can override the properties and methods to implement your own logic.
##
## -- NOTE -------------------------------------------------------------
## You should not override other DialogBox methods that are not here,
## because they are necessary to handle the dialog boxes.
## ---------------------------------------------------------------------
# -----------------------------------------------------------------------------

func _on_dialog_box_open() -> void:
	# --------------------------------------------------------------------------
	# This method is called when the dialog box starts.
	# You can add your own logic here to handle the start of the dialog box.
	# (e.g. play an animation to enter to the scene)
	# --------------------------------------------------------------------------
	# In this base case, the dialog box only is shown when it starts
	show()
	_connect_ui_sounds(self)


func _on_dialog_box_close() -> void:
	# --------------------------------------------------------------------------
	# This method is called when the dialog box is closed.
	# You can add your own logic here to handle the closing of the dialog box.
	# (e.g. play an animation to exit the scene)
	# --------------------------------------------------------------------------
	# In this base case, the dialog box only is hidden when closed
	hide()


func _on_options_displayed() -> void:
	# --------------------------------------------------------------------------
	# This method is called when the dialog options are displayed.
	# You can add your own logic here to handle when the options are displayed.
	# (e.g. play an animation to display the options)
	# --------------------------------------------------------------------------
	if options_container:
		options_container.show()
		var cs =  options_container.get_children()
		var first_option: DialogOption = cs.filter(func(c): return c.visible)[0]
		first_option.call_deferred("grab_focus")
		
		_connect_ui_sounds(options_container)



func _on_options_hidden() -> void:
	# --------------------------------------------------------------------------
	# This method is called when the dialog options are hidden.
	# You can add your own logic here to handle when the options are hidden.
	# (e.g. play an animation to hide the options)
	# --------------------------------------------------------------------------
	if options_container:
		options_container.hide()

## Set a portrait to be displayed in the dialog box
func display_portrait(character_parent: Node, portrait_node: Node) -> void:
	if not portrait_display:
		printerr("[Sprouty Dialogs] Cannot display the portrait in the dialog box. The dialog box doesn't have a portrait display.")
	
	if not portrait_display.has_node(NodePath(character_parent.name)):
		character_parent.add_child(portrait_node)
		portrait_display.add_child(character_parent)
	else:
		# If the character node already exists, add the portrait to it
		portrait_display.get_node(NodePath(character_parent.name)).add_child(portrait_node)
	_is_displaying_portrait = true

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

func _dialog_clicked() -> void:
	AudioManager.play_ui_focus()
