@tool
class_name Pin 
extends Node2D

@onready var rest_position: StaticBody2D = %RestPosition
@onready var groove: GrooveJoint2D = %groove
@onready var spring: DampedSpringJoint2D = %spring
@onready var pin: RigidBody2D = %Pin
@onready var cylinder: RigidBody2D = %cylinder
@onready var unlock_area: Area2D = %unlock_area

signal lock_state_change

@export_range(0,64)
var spring_strength: float = 32:
	set(val):
		spring_strength = val
		if groove != null : 
			spring.stiffness = spring_strength
@export_range(-20, 20)
var move_upper: float = 0:
	set(val): 
		move_upper = val
		if groove != null && spring != null: 
			groove.position = Vector2(0, move_upper)
			spring.position = Vector2(0, move_upper)
			pin.position = Vector2(0, move_upper)
			rest_position.position = Vector2(0, move_upper)
			
@export_range(0, 128)
var move_lower: float =  64:
	set(val): 
		move_lower = val
		if groove != null : 
			groove.length = move_lower 
			spring.length = move_lower
	
## if the pin is unlocked / placed in the correct position
var unlocked: bool = false:
	set(val):
		unlocked = val
		lock_state_change.emit()
	
func _ready() -> void:
	if Engine.is_editor_hint(): return 
	
	spring_strength = spring_strength
	move_lower = move_lower
	move_upper = move_upper
	
	
func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint(): return 
	
	var turning: float = Input.get_axis("turner_tight", "turner_loose")
	if abs(turning) >= 0.0001:
		cylinder.linear_velocity.x = turning * 100
	else:
		cylinder.linear_velocity.x = clamp(cylinder.linear_velocity.x, -100, 10)

func _on_unlock_area_body_entered(body: Node2D) -> void:
	unlocked = true
	#$pin_assembly/Pin/Icon.modulate = Color.RED
func _on_unlock_area_body_exited(body: Node2D) -> void:
	unlocked = false
	#$pin_assembly/Pin/Icon.modulate = Color.WHITE
