@tool
class_name Pin 
extends Node2D

@onready var rest_position: StaticBody2D = $RestPosition
@onready var groove: GrooveJoint2D = $groove
@onready var spring: DampedSpringJoint2D = $spring
@onready var pin: RigidBody2D = $Pin

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
			
@export_range(0, 64)
var move_lower: float =  24:
	set(val): 
		move_lower = val
		if groove != null : 
			groove.length = move_lower 
			spring.length = move_lower
	
func _ready() -> void:
	if Engine.is_editor_hint(): return 
	
	spring_strength = spring_strength
	move_lower = move_lower
	move_upper = move_upper
