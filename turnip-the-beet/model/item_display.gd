class_name ItemDisplay extends Resource


var	data: Array2D
signal item_display_changed

func get_value(x: int, y: int) -> Item: 
	return data.get_value(Vector2i(x, y))
	
func set_value(x: int, y: int, value: Item):
	data.set_value(value, Vector2i(x, y))
	item_display_changed.emit()

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
	
func is_empty() -> bool:
	for y in data._y_max:
		for x in data._x_max:
			if has_value(x, y):
				return false
	return true

func delete_value(x: int, y: int):
	data.set_value(null, Vector2i(x, y))
	item_display_changed.emit()

func has_value(x: int, y: int) -> bool:
	return data.has_value(Vector2i(x, y))
	

static func constructor() -> ItemDisplay:
	var item_display = ItemDisplay.new()
	item_display.data = Array2D.constructor(4,1)
	return item_display
