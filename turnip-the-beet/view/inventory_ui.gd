class_name InventoryUi extends Control

enum InventoryState {
	OPEN,
	CLOSED
}

@onready var inventory_slot_packed_scene: PackedScene = preload("res://view/inventory_slot.tscn")
@onready var grid_container = $GridContainer
var inventory: Inventory
var inventory_state: InventoryState = InventoryState.CLOSED:
	set(value):
		inventory_state = value
		_process_state(value)

func _ready():
	inventory = Model.inventory
	_process_state(inventory_state)
	grid_container.columns = inventory.data._x_max
	for y in range(inventory.data._y_max):
		for x in range(inventory.data._x_max): 
			var inventory_slot: InventorySlot = inventory_slot_packed_scene.instantiate()
			inventory_slot.x = x
			inventory_slot.y = y
			grid_container.add_child(inventory_slot)

func _process(delta):
	if Input.is_action_just_pressed("Inventory"):
		match inventory_state:
			InventoryState.CLOSED:
				inventory_state = InventoryState.OPEN
			InventoryState.OPEN:
				inventory_state = InventoryState.CLOSED
			_:
				inventory_state = InventoryState.CLOSED

func _process_state(state: InventoryState):
	match inventory_state:
		InventoryState.CLOSED:
			visible = false
		InventoryState.OPEN:
			visible = true
		_:
			visible = false
