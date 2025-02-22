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

static func load_melodie(path_to_file: String) -> Melodie:
	if FileAccess.file_exists(path_to_file):
		var file_content = FileAccess.get_file_as_string(path_to_file)
		var dict = JSON.parse_string(file_content)
		var note_definitions = dict["platforms"]
		var notes: Array[Note] = []
		var tact: int = 0
		var tick: int = 0
		var index: int = 0
		while index < len(note_definitions):
			var definition = note_definitions[index]
			if tact < definition["tact"] or tick < definition["tick"]:
				if tick == 15:
					tick = 0
					tact += 1
				else:
					tick += 1
				notes.append(Note.constructor(
					Note.Tone.NONE,
					1
				))
				continue
			else:
				var note_length = definition["note_length"]
				var tone = definition["note_pitch"]
				index += 1
				tick = (tick + note_length)
				if tick >= 16:
					tick = tick % 16
					tact += 1
				notes.append(Note.constructor(
					tone,
					note_length
				))
		if tick != 0:
			notes.append(
				Note.constructor(
					Note.Tone.NONE,
					16 - tick
				)
			)
		var melodie = Melodie.new()
		melodie.notes = notes
		return melodie
	return null
