class_name SpookPoint
extends Marker3D


func _ready() -> void:
	HauntedPlaces.register_place(self)
