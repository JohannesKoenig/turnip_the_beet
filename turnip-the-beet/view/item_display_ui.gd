class_name ItemDisplayUi extends Control

enum ItemDisplayState {
	OPEN,
	CLOSED
}

@onready var item_display_slot_packed_scene: PackedScene = preload("res://view/item_display_slot.tscn")
@onready var inventory_ui = $MarginContainer/HBoxContainer/InventoryUi
@onready var sell_button = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/HBoxContainer/SellButton

@onready var label = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/HBoxContainer/HBoxContainer/Label

@onready var grid_container = $MarginContainer/HBoxContainer/VBoxContainer/GridContainer

var item_display: ItemDisplay
var inventory: Inventory
var money: Money
var slots: Array[ItemDisplaySlot] = []
var item_display_state: ItemDisplayState = ItemDisplayState.CLOSED:
	set(value):
		item_display_state = value
		_process_state(value)
		item_display_state_changed.emit(value)
signal item_display_state_changed(value: ItemDisplayState)

func _ready():
	item_display = Model.item_display
	inventory = Model.inventory
	money = Model.money
	sell_button.disabled = true
	inventory_ui.inventory_state = InventoryUi.InventoryState.OPEN
	Clipboard.selected_inventory_item_changed.connect(_on_selected_inventory_item_changed)
	_process_state(item_display_state)
	grid_container.columns = item_display.data._x_max
	for y in range(item_display.data._y_max):
		for x in range(item_display.data._x_max): 
			var item_display_slot: ItemDisplaySlot = item_display_slot_packed_scene.instantiate()
			slots.append(item_display_slot)
			#item_display_slot.selected_changed.connect(_on_slot_selected_changed)
			#item_display_slot.clicked.connect(_on_slot_clicked)
			item_display_slot.x = x
			item_display_slot.y = y
			grid_container.add_child(item_display_slot)


func _process_state(state: ItemDisplayState):
	match item_display_state:
		ItemDisplayState.CLOSED:
			visible = false
		ItemDisplayState.OPEN:
			visible = true
		_:
			visible = false

func _on_slot_clicked(slot: ItemDisplaySlot):
	for elem in slots:
		elem.selected = false
	slot.selected = true

func _on_selected_inventory_item_changed(item: Item):
	if item != null:
		label.text = str(item.price)
		sell_button.disabled = false
	else:
		label.text = "-"
		sell_button.disabled = true


func _on_sell_button_pressed():
	if Clipboard.selected_inventory_item != null:
		var item = Clipboard.selected_inventory_item
		if item == null:
			return
		if item_display.has_space():
			inventory.delete_value(
				Clipboard.selected_inventory_item_source_pos.x,
				Clipboard.selected_inventory_item_source_pos.y
			)
			item_display.add_value(item)
			Clipboard.selected_inventory_item = null
			Clipboard.selected_inventory_item_source_pos = Vector2i(-1, -1)
