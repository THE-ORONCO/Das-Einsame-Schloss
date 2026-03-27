extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var animation: AnimatedSprite3D = %animation
@onready var emp_tex: AnimatedTexture = %emp.texture
@onready var light: SpotLight3D = %light
@onready var light_rot: float = %light.global_rotation.y

@export
var spook_increments: Array[float] = [1000000, 5, 4, 2, 1, .5]

func _physics_process(delta: float) -> void:
	if GameState.current_state != GameState.WALKING: return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("player_left", "player_right", "player_up", "player_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	_animate_sprite()
	_update_emp()


func _animate_sprite() -> void:
	if velocity.length_squared() < 0.1:
		animation.play("idle")
		light.rotation.y = light_rot
		return
	
	var dir := velocity.normalized()
	if abs(dir.x) > abs(dir.z):
		if dir.x > 0: 
			animation.play("right")
			light.global_rotation.y = light_rot + PI/2
		if dir.x < 0: 
			animation.play("left")
			light.global_rotation.y = light_rot - PI/2
	elif abs(dir.x) < abs(dir.z) :
		if dir.z > 0: 
			animation.play("down")
			light.global_rotation.y = light_rot
		if dir.z < 0:
			animation.play("up")
			light.global_rotation.y = light_rot + PI


func _update_emp() -> void:
	var distance := HauntedPlaces.nearest_spook_distance(self.global_position)
	var max_spook := spook_increments.size()
	for i in range(max_spook):
		var increment := spook_increments[i]
		if distance <= increment:
			var random_offset := randf() *3 - 1
			emp_tex.current_frame = clampf(i + random_offset, 0, max_spook - 1) 

	
	
