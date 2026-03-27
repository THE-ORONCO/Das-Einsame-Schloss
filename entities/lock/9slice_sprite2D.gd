@tool
extends Sprite2D
const _9_SLICE_SHADER: Shader = preload("uid://dbxj0wb725ywe")

@export_group("thingy")
@export_range(0, 1000) var right: int = 0
@export_range(0, 1000) var top: int = 0
@export_range(0, 1000) var left: int = 0
@export_range(0, 1000) var bottom: int = 0

func _ready():
	set_notify_transform(true)
	var sm: ShaderMaterial = ShaderMaterial.new()
	sm.shader = _9_SLICE_SHADER
	sm.set_shader_parameter("right", right)
	sm.set_shader_parameter("top", top)
	sm.set_shader_parameter("left", left)
	sm.set_shader_parameter("bottom", bottom)
	material = sm


func _notification(what):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		(get_material() as ShaderMaterial).set_shader_parameter("scale", scale)
