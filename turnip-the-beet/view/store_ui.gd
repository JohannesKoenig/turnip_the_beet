class_name StoreUi extends Control

enum StoreState {
	OPEN,
	CLOSED
}

@onready var store_slot_packed_scene: PackedScene = preload("res://view/store_slot.tscn")
@onready var inventory_ui = $MarginContainer/HBoxContainer/InventoryUi

@onready var grid_container = $MarginContainer/HBoxContainer/VBoxContainer/GridContainer
@onready var label = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/HBoxContainer/Label
@onready var buy_button = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/BuyButton


var store: Store
var inventory: Inventory
var money: Money
var slots: Array[StoreSlot] = []
var store_state: StoreState = StoreState.CLOSED:
	set(value):
		store_state = value
		_process_state(value)
		store_state_changed.emit(value)
signal store_state_changed(value: StoreState)

func _ready():
	buy_button.disabled = true
	store = Model.store
	inventory = Model.inventory
	money = Model.money
	inventory_ui.inventory_state = InventoryUi.InventoryState.OPEN
	_process_state(store_state)
	grid_container.columns = store.data._x_max
	for y in range(store.data._y_max):
		for x in range(store.data._x_max): 
			var store_slot: StoreSlot = store_slot_packed_scene.instantiate()
			slots.append(store_slot)
			store_slot.selected_changed.connect(_on_slot_selected_changed)
			store_slot.clicked.connect(_on_slot_clicked)
			store_slot.x = x
			store_slot.y = y
			grid_container.add_child(store_slot)


func _process_state(state: StoreState):
	match store_state:
		StoreState.CLOSED:
			visible = false
		StoreState.OPEN:
			visible = true
		_:
			visible = false

func _on_slot_clicked(slot: StoreSlot):
	for elem in slots:
		elem.selected = false
	slot.selected = true

func _on_slot_selected_changed():
	for slot in slots:
		if slot.selected:
			Clipboard.selected_store_item = slot.item
			if slot.item != null:
				buy_button.disabled = false
				label.text = str(slot.item.price)
			return
	Clipboard.selected_store_item = null
	buy_button.disabled = true
	label.text = "-"

func _on_buy_button_pressed():
	if Clipboard.selected_store_item != null:
		var item = Clipboard.selected_store_item
		if money.can_pay(item.price) and inventory.has_space():
			inventory.add_value(item)
			money.pay(item.price)
