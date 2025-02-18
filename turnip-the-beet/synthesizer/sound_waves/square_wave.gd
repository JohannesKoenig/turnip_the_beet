class_name SquareWave extends SoundWave


func apply(phase: float) -> Vector2:
	return Vector2.ONE * floor(phase * 2.0)
