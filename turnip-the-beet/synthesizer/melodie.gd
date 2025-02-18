class_name Melodie extends Resource

@export var notes: Array[Note] = []


func get_note(tact: int, tick: int) -> Note:
	var total_length: float = 0
	for note in notes:
		total_length += note.length
	var nr_of_tacts = int(total_length / 16)
	if nr_of_tacts == 0:
		return null
	var target_tick = (tact%nr_of_tacts) * 16 + tick
	var progress = 0
	for note in notes:
		if progress <= target_tick and target_tick < progress + note.length:
			return note
		progress += note.length
	return null
