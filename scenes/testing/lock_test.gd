extends Node2D

var pins: Array[Pin]

signal unlocked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for pin in %pins.get_children().filter(func(c) : return c is Pin):
		pin = pin as Pin
		pins.append(pin)
		pin.lock_state_change.connect(_check_unlocked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _check_unlocked():
	if pins.all(func (pin): return pin.unlocked):
		unlocked.emit()
