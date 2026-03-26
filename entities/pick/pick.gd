extends CharacterBody2D


const SPEED: Vector2 = Vector2(100,20)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	var move_dir: Vector2 = Input.get_vector("pick_left", "pick_right", "pick_up", "pick_down")
	var vel: Vector2 = move_dir * SPEED
	self.velocity = vel
	
	var turn: float = Input.get_axis("turner_loose", "turner_tight")
	

	move_and_slide()
