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

var slots: Array[InventorySlot] = []


func _ready():
	inventory = Model.inventory
	_process_state(inventory_state)
	grid_container.columns = inventory.data._x_max
	for y in range(inventory.data._y_max):
		for x in range(inventory.data._x_max): 
			var inventory_slot: InventorySlot = inventory_slot_packed_scene.instantiate()
			slots.append(inventory_slot)
			inventory_slot.selected_changed.connect(_on_slot_selected_changed)
			inventory_slot.clicked.connect(_on_slot_clicked)
			inventory_slot.x = x
			inventory_slot.y = y
			grid_container.add_child(inventory_slot)


func _process_state(state: InventoryState):
	match inventory_state:
		InventoryState.CLOSED:
			visible = false
		InventoryState.OPEN:
			visible = true
		_:
			visible = false

func _on_slot_clicked(slot: InventorySlot):
	for elem in slots:
		elem.selected = false
	slot.selected = true

func _on_slot_selected_changed():
	for slot in slots:
		if slot.selected:
			Clipboard.selected_inventory_item = slot.item
			Clipboard.selected_inventory_item_source_pos = Vector2i(
				slot.x, slot.y
			)
			return
	Clipboard.selected_inventory_item = null
