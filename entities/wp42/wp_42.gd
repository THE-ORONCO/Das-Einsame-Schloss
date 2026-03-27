class_name WP42
extends RigidBody2D


@export
var speed: Vector2 = Vector2(700,300)

@export_range(0., 3.)
var turn_speed: float = 1

var _extent: Vector2
var _affected_pins: Dictionary[NodePath, Pin] = {}

func _ready() -> void:
	_extent = DisplayServer.screen_get_size()
	GameState.pick_was_equipped.connect(self.hide)
	GameState.wp42_was_equipped.connect(self.show)
	self.hide()


func _physics_process(delta: float) -> void:
	if GameState.current_state != GameState.LOCK_PICK: return
	if GameState.pick_equipped: return
	
	if Input.is_action_just_pressed("use_pick"):
		GameState.equip_pick()
		return
	
	var move_dir: Vector2 = Input.get_vector("pick_left", "pick_right", "pick_up", "pick_down")
	self.linear_velocity = move_dir * speed
		 
	var turn: float = Input.get_axis("pick_anti_clockwise", "pick_clockwise")
	self.angular_velocity = turn * turn_speed
	
	self.lock_rotation = !Input.is_action_pressed("pick_anti_clockwise") && !Input.is_action_pressed("pick_clockwise")
	
	move_and_collide(Vector2.ZERO)
	
	var max: float = clamp(self.position.x, 0, _extent.x)
	var may: float = clamp(self.position.y, 0, _extent.y)
	self.position = Vector2(max, may)
	
	for pin in _affected_pins.values():
		if pin.rust >= 0.6:
			pin.rust = move_toward(pin.rust, 0.6, delta * 10)


func _pin_entered(body: Node2D) -> void:
	var grand_parent := body.get_parent().get_parent()
	if grand_parent is Pin:
		_affected_pins[grand_parent.get_path()] = grand_parent


func _pin_exited(body: Node2D) -> void:
	var grand_parent := body.get_parent().get_parent()
	_affected_pins.erase(grand_parent.get_path())
