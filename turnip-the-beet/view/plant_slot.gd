class_name PlantSlot extends Node2D

const width: int = 16
const height: int = 16

var plant: Plant
var plant_entity_packed_scene = preload("res://view/plant_entity.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	if plant == null:
		return
	var plant_entity: PlantEntity = plant_entity_packed_scene.instantiate()
	plant_entity.plant = plant
	add_child(plant_entity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
