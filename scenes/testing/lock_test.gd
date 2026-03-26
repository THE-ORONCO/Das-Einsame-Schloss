class_name Lock
extends Node2D

var pins: Array[Pin]

signal unlocked

@export
var dialog_after: DialogPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.set_state(GameState.LOCK_PICK)
	for pin in %pins.get_children().filter(func(c) : return c is Pin):
		pin = pin as Pin
		pins.append(pin)
		pin.lock_state_change.connect(_check_unlocked)

func _check_unlocked():
	if pins.all(func (pin): return pin.unlocked):
		print("unlocked")
		unlocked.emit()
		if dialog_after != null:
			dialog_after.start()
			dialog_after.dialog_ended.connect(self.queue_free)
		else:
			GameState.walk()
			self.queue_free()
		
