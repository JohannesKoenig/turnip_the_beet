class_name MelodiePlayer extends Node

@export var melodie: Melodie
@export var synthesizer: Synthesizer
@export var playing: bool = true

func _ready():
	Metronome.new_tick.connect(_on_tick_changed)
	_on_tick_changed(Metronome.get_tact(), Metronome.get_tick())


func _on_tick_changed(tact: int, tick: int):
	if not playing:
		return
	if melodie == null:
		return
	var note = melodie.get_note(tact, tick)
	synthesizer.play(note)
