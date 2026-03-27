class_name SpookPoint
extends Marker3D


func _ready() -> void:
	HauntedPlaces.register_place(self)
	tree_exiting.connect(_on_tree_exiting)

func _on_tree_exiting() -> void:
	HauntedPlaces.unregister_place(self)
