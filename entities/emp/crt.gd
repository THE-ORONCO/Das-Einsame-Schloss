extends Control

@onready var shading: ShaderMaterial = %shading.material

var _base: float
var _target: float = 0

func _ready() -> void:
	_base = shading.get_shader_parameter("static_noise_intensity")

func spook(amount: float = 0) -> void:
	_target = clampf(_target + amount, 0, 1)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		spook(1)
	
	var noise: float = shading.get_shader_parameter("static_noise_intensity")
	_target = move_toward(_target, _base, delta * .5)
	shading.set_shader_parameter("static_noise_intensity", _target)
