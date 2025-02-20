class_name GameScene extends Node2D
@onready var spawn_marker = $SpawnMarker
@onready var despawn_marker = $DespawnMarker
@onready var buy_marker = $BuyMarker
@onready var listen_marker = $ListenMarker

var last_spawn: float
var pedestrian_entity_packed_scene = preload("res://view/pedestrian_entity.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	_spawn_pedestrian()

func _process(delta):
	var now = Time.get_unix_time_from_system()
	if now - last_spawn > 5:
		_spawn_pedestrian()

func _spawn_pedestrian():
	var actions = Pedestrian.generate_actions(spawn_marker.position, buy_marker.position, listen_marker.position, despawn_marker.position)
	var pedestrian = Pedestrian.constructor(actions)
	var pedestrian_entity: PedestrianEntity = pedestrian_entity_packed_scene.instantiate()
	pedestrian_entity.position = spawn_marker.position
	pedestrian_entity.pedestrian = pedestrian
	add_child(pedestrian_entity)
	last_spawn = Time.get_unix_time_from_system()
