class_name Daytime extends Resource

enum Season {
	SPRING,
	SUMMER,
	FALL,
	WINTER
}

var season: Season = Season.SPRING
var hour: int:
	set(value):
		if hour != value:
			hour = value
			hour_changed.emit(value)
signal hour_changed(value: int)
var day: int:
	set(value):
		if day != value:
			day = value
			day_changed.emit(value)
signal day_changed(value: int)

var _hour_length: int = 2:
	set(value):
		_hour_length = value
		_day_length = value * 24

var _day_length: int = 2 * 24
var _day_start_time: float

func start():
	_day_start_time = Time.get_unix_time_from_system()

func update():
	var now = Time.get_unix_time_from_system()
	var delta = now - _day_start_time
	
	hour = int(floor(delta / _hour_length))% 24 + 1
	day = int(floor(delta / _day_length))% 30 + 1
	
func is_night() -> bool:
	return hour >= 20 or hour < 6

func is_day() -> bool:
	return !is_night()
		


static func constructor():
	var daytime = Daytime.new()
	return daytime
