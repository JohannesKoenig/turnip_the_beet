class_name Store extends Resource


var	data: Array2D
signal store_changed

func get_value(x: int, y: int) -> Item: 
	return data.get_value(Vector2i(x, y))
	
func set_value(x: int, y: int, value: Item):
	data.set_value(value, Vector2i(x, y))
	store_changed.emit()

func delete_value(x: int, y: int):
	data.set_value(null, Vector2i(x, y))
	store_changed.emit()

func has_value(x: int, y: int) -> bool:
	return data.has_value(Vector2i(x, y))
	

static func constructor() -> Store:
	var store = Store.new()
	store.data = Array2D.constructor(4,1)
	var tomato = load("res://types/items/tomato.tres")
	store.set_value(1,0,tomato)
	store.set_value(0,0, load("res://types/items/tomato_seed.tres"))
	return store
