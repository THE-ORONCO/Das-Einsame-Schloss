class_name Pick
extends RigidBody2D


@export
var speed: Vector2 = Vector2(700,300)

@export_range(0., 3.)
var turn_speed: float = 1


func _physics_process(delta: float) -> void:
	if GameState.current_state != GameState.LOCK_PICK: return
	
	var move_dir: Vector2 = Input.get_vector("pick_left", "pick_right", "pick_up", "pick_down")
	self.linear_velocity = move_dir * speed
		 
	var turn: float = Input.get_axis("pick_anti_clockwise", "pick_clockwise")
	self.angular_velocity = turn * turn_speed
	
	self.lock_rotation = !Input.is_action_pressed("pick_anti_clockwise") && !Input.is_action_pressed("pick_clockwise")
	
	move_and_collide(Vector2.ZERO)
