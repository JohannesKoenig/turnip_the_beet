class_name Synthesizer extends Node2D

@export var sound_wave: SoundWave
@export var audio_stream_player: AudioStreamPlayer2D
var _sample_hz: float
var _playback: AudioStreamGeneratorPlayback
var _current_note: Note
var _phase: float = 0.0

func _ready():
	_sample_hz = audio_stream_player.stream.mix_rate

func play(note: Note):
	if note != _current_note:
		stop()
		_current_note = note

func stop():
	_playback = null
	_current_note = null
	audio_stream_player.stop()
	audio_stream_player.stream = AudioStreamGenerator.new()
	audio_stream_player.play()
	_playback = audio_stream_player.get_stream_playback()
	_sample_hz = audio_stream_player.stream.mix_rate

func _process(delta):	
		_fill_buffer(_current_note)

func _fill_buffer(note: Note):
	if _playback == null:
		return
	if _current_note == null:
		return
	var tone = _current_note.tone
	if tone == Note.Tone.NONE:
		return
	var increment = Note.map_tone(tone) / _sample_hz
	var frames_available = _playback.get_frames_available()
	for i in range(frames_available):
		var value = sound_wave.apply(_phase)
		_playback.push_frame(value)
		_phase = fmod(_phase + increment, 1.0)
