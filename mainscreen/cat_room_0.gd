extends CharacterBody2D
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 2.0
		
	move_and_slide()
