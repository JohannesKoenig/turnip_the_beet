class_name Inventory extends Resource 

var	data: Array2D
signal inventory_changed
var selected_item: Vector2i = Vector2i(-1, -1):
	set(value):
		if value != selected_item:
			selected_item = value
			selected_item_changed.emit(value)
signal selected_item_changed(selected: Vector2i)

func get_value(x: int, y: int) -> Item: 
	return data.get_value(Vector2i(x, y))
	
func set_value(x: int, y: int, value: Item):
	data.set_value(value, Vector2i(x, y))
	inventory_changed.emit()

func add_value(value: Item):
	for y in data._y_max:
		for x in data._x_max:
			if not has_value(x, y):
				set_value(x, y, value)
				return

func has_space() -> bool:
	for y in data._y_max:
		for x in data._x_max:
			if not has_value(x, y):
				return true
	return false

func select_item(x: int, y: int):
	if has_value(x, y):
		selected_item = Vector2i(x, y)

func deselect_item(x: int, y: int):
	selected_item = Vector2i(-1, -1)

func delete_value(x: int, y: int):
	data.set_value(null, Vector2i(x, y))
	inventory_changed.emit()

func has_value(x: int, y: int) -> bool:
	return data.has_value(Vector2i(x, y))

static func constructor() -> Inventory:
	var inventory = Inventory.new()
	inventory.data = Array2D.constructor(4,3)
	var apple = load("res://types/items/tomato_seed.tres")
	inventory.set_value(1,1,apple)
	return inventory
