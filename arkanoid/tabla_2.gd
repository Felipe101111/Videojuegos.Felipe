extends CharacterBody2D


const SPEED = 500.0

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("izquierda2", "derecha2")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_collide(velocity * delta)
