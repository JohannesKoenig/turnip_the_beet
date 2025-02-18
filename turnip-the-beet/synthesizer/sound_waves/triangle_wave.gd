class_name TriangleWave extends SoundWave


func apply(phase: float) -> Vector2:
	return Vector2.ONE * 2 * abs(1/phase - floor(1/phase + 0.5))
