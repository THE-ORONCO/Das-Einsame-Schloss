extends Node


var locations: Array[Node3D] = []

func _ready() -> void:
	locations = []

func register_place(place: Node3D) -> void:
	locations.append(place)
	
func nearest_spook_distance(global_pos: Vector3) -> float:
	var nearest := 1000000.
	for location in locations:
		nearest = minf(location.global_position.distance_to(global_pos), nearest)
	return nearest

func unregister_place(place: Node3D) -> void:
	locations.erase(place)
