extends Control

@export var audio_bus_name: String
var audio_bus_id
@onready var h_slider: HSlider = $HBoxContainer/HSlider

func _ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	var label = $HBoxContainer/Label
	label.text = audio_bus_name 


func _on_h_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)


func _on_focus_entered() -> void:
	h_slider.call_deferred("grab_focus")
