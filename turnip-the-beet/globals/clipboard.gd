extends Node


var dragged_item: Item
var source_pos: Vector2i
var dragging: bool

var selected_store_item: Item:
	set(value):
		if selected_store_item != value:
			selected_store_item = value
			selected_store_item_changed.emit(value)
signal selected_store_item_changed(item: Item)
var selected_store_item_source_pos: Vector2i

var selected_item_display_item: Item:
	set(value):
		if selected_item_display_item != value:
			selected_item_display_item = value
			selected_item_display_item_changed.emit(value)
signal selected_item_display_item_changed(item: Item)
var selected_item_display_item_source_pos: Vector2i

var selected_inventory_item: Item:
	set(value):
		if selected_inventory_item != value:
			selected_inventory_item = value
			selected_inventory_item_changed.emit(value)
signal selected_inventory_item_changed(item: Item)
var selected_inventory_item_source_pos: Vector2i
