class_name Garden extends Resource 

var	data: Array2D
signal garden_changed

func get_value(x: int, y: int) -> Plant: 
	return data.get_value(Vector2i(x, y))
	
func set_value(x: int, y: int, value: Plant):
	data.set_value(value, Vector2i(x, y))
	garden_changed.emit()

func delete_value(x: int, y: int):
	data.set_value(null, Vector2i(x, y))
	garden_changed.emit()

func has_value(x: int, y: int) -> bool:
	return data.has_value(Vector2i(x, y))
	

static func constructor() -> Garden:
	var garden = Garden.new()
	garden.data = Array2D.constructor(5,3)
	var tomato = load("res://types/plants/tomato_plant.tres")
	garden.set_value(1, 1, tomato)
	return garden
