class_name Note extends Resource

@export var tone: Tone
@export var length: int = 1

enum Tone {
	NONE,
	a1,
	b1,
	c1,
	d1,
	e1,
	f1,
	g1,
	bigC1,
}

static func map_tone(tone: Tone) -> float:
	match tone:
		Tone.NONE:
			return 0
		Tone.c1:
			return 261.626
		Tone.d1:
			return 293.665
		Tone.e1:
			return 329.628
		Tone.f1:
			return 349.228
		Tone.g1:
			return 391.995
		Tone.a1:
			return 440
		Tone.b1:
			return 493.883
		Tone.bigC1:
			return 65.4064
		_:
			return 0

static func map_tone_color(tone: Tone) -> Color:
	match tone:
		Tone.NONE:
			return Color(1, 1, 1, 0.1)
		Tone.c1:
			return Color(1, 0, 0)
		Tone.d1:
			return Color(1, 0.5, 0)
		Tone.e1:
			return Color(1, 1, 0)
		Tone.f1:
			return Color(0.5, 1, 0)
		Tone.g1:
			return Color(0, 1, 0)
		Tone.a1:
			return Color(0, 1, 0.5)
		Tone.b1:
			return Color(0, 1, 1)
		Tone.bigC1:
			return Color(0, 0.5, 1)
		_:
			return Color.BLACK

static func constructor(tone: Tone, length: int = 1) -> Note:
	var note = Note.new()
	note.tone = tone
	note.length = length
	return note
