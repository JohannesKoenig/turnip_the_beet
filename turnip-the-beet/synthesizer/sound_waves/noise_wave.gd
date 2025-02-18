class_name NoiseWave extends SoundWave

@export var noise: FastNoiseLite

func apply(phase: float) -> Vector2:
	var time = Time.get_unix_time_from_system()
	return Vector2.ONE * noise.get_noise_1d(phase * time)
