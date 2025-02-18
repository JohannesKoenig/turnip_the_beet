class_name SineWave extends SoundWave

func apply(phase: float) -> Vector2:
	return Vector2.ONE * sin(phase * TAU)
