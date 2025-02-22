extends CanvasModulate

var daytime: Daytime
@export var night_color: Color
@export var day_color: Color
var target_color: Color

func _ready():
	daytime = Model.daytime
	daytime.hour_changed.connect(_update_color)
	_update_color(daytime.hour)
	color = target_color

func _process(delta):
	color = lerp(color, target_color, delta)

func _update_color(hour: int):
	if daytime.is_night():
		target_color = night_color
	else:
		target_color = day_color
