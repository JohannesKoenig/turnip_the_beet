class_name Note extends Resource

@export var tone: Tone
@export var length: int = 1

enum Tone {
	NONE = 0,
	c1 = 91,
	d1 = 89,
	e1 = 87,
	f1 = 86,
	g1 = 84,
	a1 = 82,
	b1 = 80,
	c2 = 79,
	d2 = 77,
	e2 = 75,
	f2 = 74,
	g2 = 72,
	a2 = 70,
	b2 = 68,
	c3 = 67,
	d3 = 65,
	e3 = 63,
	f3 = 62,
	g3 = 60,
	a3 = 58,
	b3 = 56,
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
		Tone.c2:
			return 523.251
		Tone.d2:
			return 587.330
		Tone.e2:
			return 659.255
		Tone.f2:
			return 698.456
		Tone.g2:
			return 783.991
		Tone.a2:
			return 880
		Tone.b2:
			return 987.767
		Tone.c3:
			return 1046.50
		Tone.d3:
			return 1174.66
		Tone.e3:
			return 1318.51
		Tone.f3:
			return 1396.91
		Tone.g3:
			return 1567.98
		Tone.a3:
			return 1760
		Tone.b3:
			return 1975.53
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
