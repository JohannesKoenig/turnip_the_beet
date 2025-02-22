class_name GardenEntity extends Node2D


var garden: Garden
@onready var plant_slot_packed_scene = preload("res://view/plant_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	garden = Model.garden
	
	for y in range(garden.data._y_max):
		for x in range(garden.data._x_max): 
			var plant_slot: PlantSlot = plant_slot_packed_scene.instantiate()
			plant_slot.x = x
			plant_slot.y = y
			plant_slot.plant = garden.get_value(x, y)
			add_child(plant_slot)
			plant_slot.position=Vector2(plant_slot.width * x, plant_slot.height * y)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
