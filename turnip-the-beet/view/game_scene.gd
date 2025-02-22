class_name GameScene extends Node2D
@onready var spawn_marker = $SpawnMarker
@onready var despawn_marker = $DespawnMarker
@onready var buy_marker = $BuyMarker
@onready var listen_marker = $ListenMarker
@onready var point_light_2d = $Lights/PointLight2D
@onready var point_light_2d_2 = $Lights/PointLight2D2

var last_spawn: float
var pedestrian_entity_packed_scene = preload("res://view/pedestrian_entity.tscn")
var daytime: Daytime
var light_alpha: float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	daytime = Model.daytime
	daytime.hour_changed.connect(_on_hour_changed)
	_on_hour_changed(daytime.hour)
	point_light_2d.energy = light_alpha
	point_light_2d_2.energy = light_alpha
	_spawn_pedestrian()

func _process(delta):
	var now = Time.get_unix_time_from_system()
	if now - last_spawn > 5:
		_spawn_pedestrian()
	point_light_2d.energy = lerp(point_light_2d.energy, light_alpha, delta)
	point_light_2d_2.energy = lerp(point_light_2d_2.energy, light_alpha, delta)

func _on_hour_changed(hour: int):
	if daytime.is_day():
		light_alpha = 0.0
	else:
		light_alpha = 1.0

func _spawn_pedestrian():
	var from_left = randf() > 0.5
	var spawn = spawn_marker.position
	var despawn = despawn_marker.position
	if not from_left:
		spawn = despawn_marker.position
		despawn = spawn_marker.position
	var actions = Pedestrian.generate_actions(
		spawn, 
		buy_marker.position + Vector2(randf_range(-3, 3), randf_range(-1, 1)), 
		listen_marker.position + Vector2(randf_range(0, 20), randf_range(-1, 1)), 
		despawn,
		Model.garden,
		Model.item_display
	)
	var pedestrian = Pedestrian.constructor(actions)
	var pedestrian_entity: PedestrianEntity = pedestrian_entity_packed_scene.instantiate()
	pedestrian_entity.position = spawn_marker.position
	pedestrian_entity.pedestrian = pedestrian
	add_child(pedestrian_entity)
	last_spawn = Time.get_unix_time_from_system()
