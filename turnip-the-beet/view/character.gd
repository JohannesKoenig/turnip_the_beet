extends CharacterBody2D


const SPEED = 150.0


func _physics_process(delta):


	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	var normalized = direction.normalized()
	if direction:
		velocity = lerp(velocity, normalized * SPEED, delta * 20)
	else:
		velocity = lerp(velocity, Vector2.ZERO, delta * 30)

	move_and_slide()
