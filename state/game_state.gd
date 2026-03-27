extends Node


enum {
	WALKING,
	DIALOGUE,
	LOCK_PICK,
}

var current_state = WALKING

enum Locks {
	TEST
}
const TEST_LOCK: PackedScene = preload("uid://d4e0pcnkiwhcu")
const ENTRANCE_LOCK: PackedScene = preload("uid://c34fep77d45tx")
const VERY_RUSTED_LOCK = preload("uid://cdgfekcdq35m6")

@onready var popup_canvas: CanvasLayer

signal main_menu_opened

signal pick_was_equipped
signal wp42_was_equipped
var pick_equipped: bool = true
func equip_pick() -> void: 
	pick_equipped = true
	pick_was_equipped.emit()
func equip_wp42() -> void:
	pick_equipped = false
	wp42_was_equipped.emit()

func walk() -> void: current_state = WALKING
func talk() -> void: current_state = DIALOGUE
func _pick(lock: PackedScene) -> void: 
	current_state = LOCK_PICK
	var lock_scene: Lock = lock.instantiate()
	popup_canvas.add_child(lock_scene)
func set_state(game_state) -> void: current_state = game_state

func pick_test_lock() -> void: _pick(TEST_LOCK)
func pick_entrance_lock() -> void: _pick(ENTRANCE_LOCK)
func pick_rusty_lock() -> void: _pick(VERY_RUSTED_LOCK)

func _ready() -> void:
	popup_canvas = CanvasLayer.new()
	self.add_child(popup_canvas)
	SproutyDialogs.dialog_started.connect(self.talk)
