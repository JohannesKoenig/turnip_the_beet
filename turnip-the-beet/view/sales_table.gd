class_name SalesTable extends Node2D
@onready var product_1 = $product_1
@onready var product_2 = $product_2
@onready var product_3 = $product_3
@onready var product_4 = $product_4


@onready var item_display: ItemDisplay = Model.item_display
var x: int
var y: int
var _mouse_inside: bool = false
var item: Item
var selected: bool:
	set(value):
		if selected != value:
			selected = value
			selected_changed.emit()
signal selected_changed(slot: ItemDisplaySlot)
signal clicked

func _ready():
	item_display.item_display_changed.connect(_update_slot)
	_update_slot()
	


func _update_slot():
	_update_item(0, 0, product_1)
	_update_item(1, 0, product_2)
	_update_item(2, 0, product_3)
	_update_item(3, 0, product_4)

func _update_item(x: int, y: int, sprite: Sprite2D): 
	var item = item_display.get_value(x, y)
	if item == null:
		sprite.texture = null
	else:
		sprite.texture = item.icon
