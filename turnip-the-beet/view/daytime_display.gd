class_name DaytimeDisplay extends Control
@onready var hour = $hour
@onready var day = $day
@onready var season = $season


# Called when the node enters the scene tree for the first time.
func _ready():
	var daytime = Model.daytime
	daytime.hour_changed.connect(_on_hour_changed)
	daytime.day_changed.connect(_on_day_changed)
	_on_season_changed(daytime.season)

func _on_hour_changed(value: int):
	hour.text = str(value)
	
func _on_day_changed(value: int):
	day.text = str(value)

func _on_season_changed(value: Daytime.Season):
	season.text = Daytime.Season.keys()[value]
