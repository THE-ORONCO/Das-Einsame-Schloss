@tool
class_name Pin 
extends Node2D

@onready var rest_position: StaticBody2D = %RestPosition
@onready var groove: GrooveJoint2D = %groove
@onready var spring: DampedSpringJoint2D = %spring

@export_range(0, 4)
var resistance: float = 0.5:
	set(val): set_deferred("spring.damping", val)
	get: return spring.damping
@export_range(0,64)
var spring_strength: float = 32:
	set(val): set_deferred("spring.stiffness", val)
	get: return spring.stiffness
	
@export_range(-20, 20)
var move_upper: float = 0:
	set(val): set_deferred("groove.position.y",  val)
	get: return groove.position.y
@export_range(0, 64)
var move_lower: float =  24:
	set(val): set_deferred("groove.length",val) 
	get: return groove.length
