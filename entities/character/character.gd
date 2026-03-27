extends CharacterBody3D


const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5
const DAMPED_EMP: float = 0

@onready var animation: AnimatedSprite3D = %animation
@onready var emp_tex: AnimatedTexture = %emp.texture
@onready var light: SpotLight3D = %light
@onready var light_rot: float = %light.global_rotation.y
@onready var emp_sound: AudioStreamPlayer = $emp/emp_sound
@onready var footstep_player: AudioStreamPlayer3D = $FootstepPlayer

enum DIR{
	U,
	D,
	L,
	R
}

var _current_dir: DIR = DIR.D
var _moving: bool = false
var _target_emp_pitch: float = 0.
var _target_emp_volume: float = 0.

@export
var spook_increments: Array[float] = [1000000, 12, 8, 5, 3, 1]

func _physics_process(delta: float) -> void:
	_update_emp(delta)
	
	if GameState.current_state != GameState.WALKING: return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("player_left", "player_right", "player_up", "player_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	_orientate()
	if _moving: _move_animate()
	else: _idle_animate()
	_point_light()


func _orientate() -> void:

	_moving = velocity.length_squared() > 0.1
	
	var dir := velocity.normalized()
	if abs(dir.x) > abs(dir.z):
		if dir.x > 0: _current_dir = DIR.R
		if dir.x < 0: _current_dir = DIR.L
	elif abs(dir.x) < abs(dir.z) :
		if dir.z > 0: _current_dir = DIR.D
		if dir.z < 0: _current_dir = DIR.U


func _update_emp(delta: float) -> void:
	var distance := HauntedPlaces.nearest_spook_distance(self.global_position)
	var max_spook := spook_increments.size()
	for i in range(max_spook):
		var increment := spook_increments[i]
		if distance <= increment:
			var random_offset := randf() *3 - 1
			emp_tex.current_frame = clampf(i + random_offset, 0, max_spook - 1)

	var mod = 1. / distance if distance > 0.1 else 1.
	_target_emp_pitch = move_toward(_target_emp_pitch, mod, delta)
	if GameState.current_state != GameState.WALKING:
		_target_emp_volume = move_toward(_target_emp_volume, DAMPED_EMP, delta)
	else:
		_target_emp_volume = move_toward(_target_emp_volume, mod, delta)
	emp_sound.pitch_scale = .5 + (_target_emp_pitch)
	emp_sound.volume_linear = (_target_emp_volume * 3.)

func _idle_animate() -> void:
	match _current_dir:
		DIR.U: animation.play("idle_up")
		DIR.D: animation.play("idle_down")
		DIR.L: animation.play("idle_left")
		DIR.R: animation.play("idle_right")

func _move_animate() -> void:
	match _current_dir:
		DIR.U: animation.play("walk_up")
		DIR.D: animation.play("walk_down")
		DIR.L: animation.play("walk_left")
		DIR.R: animation.play("walk_right")

func _point_light() -> void:
	match _current_dir:
		DIR.U: light.global_rotation.y = light_rot + PI
		DIR.D: light.global_rotation.y = light_rot
		DIR.L: light.global_rotation.y = light_rot - PI/2
		DIR.R: light.global_rotation.y = light_rot + PI/2
		

func _on_animation_frame_changed() -> void:
	if animation.animation.begins_with("walk_"):
		if animation.frame == 0 or animation.frame == 2:
			footstep_player.play()
