extends Node

var bpm: int = 120
var time_per_tact: float 
var time_per_tick: float

var _current_tact: int
var _current_tick: int

var _start_time: float

signal new_tick(tact: int, tick: int)

func _ready():
	var tact_per_minute: float = bpm / 4
	var tact_per_second: float = tact_per_minute / 60
	time_per_tact = 1/tact_per_second
	time_per_tick = time_per_tact / 16
	play()

func _process(delta):
	var now = Time.get_unix_time_from_system()
	var duration = now - _start_time
	var tact = int(floor(duration / time_per_tact))
	var tick = int(floor(duration / time_per_tick)) % 16
	if tact != _current_tact or tick != _current_tick:
		_current_tact = tact
		_current_tick = tick
		new_tick.emit(tact, tick)

func play():
	_start_time = Time.get_unix_time_from_system()

func get_tact() -> int:
	return _current_tact

func get_tick() -> int:
	return _current_tick
	
