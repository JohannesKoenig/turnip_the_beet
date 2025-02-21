class_name Inventory extends Resource 

var	data: Array2D
signal inventory_changed

func get_value(x: int, y: int) -> Item: 
	return data.get_value(Vector2i(x, y))
	
func set_value(x: int, y: int, value: Item):
	data.set_value(value, Vector2i(x, y))
	inventory_changed.emit()

func delete_value(x: int, y: int):
	data.set_value(null, Vector2i(x, y))
	inventory_changed.emit()

func has_value(x: int, y: int) -> bool:
	return data.has_value(Vector2i(x, y))
	

static func constructor() -> Inventory:
	var inventory = Inventory.new()
	inventory.data = Array2D.constructor(4,3)
	var apple = load("res://types/items/carrot.tres")
	inventory.set_value(1,1,apple)
	return inventory
