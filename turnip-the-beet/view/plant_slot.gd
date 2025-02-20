class_name PlantSlot extends Node2D

const width: int = 16
const height: int = 16
@onready var interactable_pop_up = $InteractablePopUp

var x: int
var y: int
var plant: Plant
var plant_entity_packed_scene = preload("res://view/plant_entity.tscn")
var player_target_entered: bool = false
var inventory: Inventory
var plant_entity: PlantEntity
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = Model.inventory


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_target_entered and _has_seeds_equiped() and _can_plant():
		interactable_pop_up.visible = true
	else: 
		interactable_pop_up.visible = false
	if Input.is_action_just_pressed("interact"):
		if player_target_entered:
			var selected_item_coords: Vector2i = inventory.selected_item
			var selected_item: Item = inventory.get_value(
				selected_item_coords.x, 
				selected_item_coords.y
			)
			if selected_item != null:
				if selected_item.item_type == Item.Type.SEED:
					var plant = Plant.constructor(selected_item.species)
					set_plant(plant)
					inventory.delete_value(
						selected_item_coords.x,
						selected_item_coords.y
					)

func _has_seeds_equiped() -> bool:
	var selected_item_coords: Vector2i = inventory.selected_item
	var selected_item: Item = inventory.get_value(
		selected_item_coords.x, 
		selected_item_coords.y
	)
	if selected_item != null:
		if selected_item.item_type == Item.Type.SEED:
			return true
	return false

func _can_plant() -> bool:
	return plant_entity == null

func set_plant(plant: Plant):
	if plant == null:
		return
	if plant_entity != null:
		plant_entity.queue_free()
	plant_entity = plant_entity_packed_scene.instantiate()
	plant_entity.x = x
	plant_entity.y = y
	plant_entity.plant = plant
	add_child(plant_entity)

func _on_area_2d_area_entered(area):
	player_target_entered = true


func _on_area_2d_area_exited(area):
	player_target_entered = false
