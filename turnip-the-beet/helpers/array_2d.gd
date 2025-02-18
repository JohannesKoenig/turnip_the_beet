class_name Array2D extends Resource

#region Private variables
var _values: Array
var _x_max: int
var _y_max: int
#endregion


#region Public static methods
static func constructor(x_max: int, y_max: int) -> Array2D:
	var array_2d = Array2D.new()
	array_2d._values = []
	array_2d._values.resize(x_max * y_max)
	array_2d._values.fill(null)
	array_2d._x_max = x_max
	array_2d._y_max = y_max
	return array_2d


#endregion


#region Public methods
func get_value(pos: Vector2i):
	## Get the value at a given position. Return null if the position is invalid.
	if !is_valid_pos(pos):
		return
	return _values[_to_1d_index(pos)]


func set_value(value, pos: Vector2i):
	## Set the value at a given position. Overwrite the value if there already
	## is one.
	if !is_valid_pos(pos):
		return
	_values[_to_1d_index(pos)] = value


func has_value(pos: Vector2i) -> bool:
	## Retrun true if a value is stored for the given position pos. Else return
	## false.
	if !is_valid_pos(pos):
		return false
	return _values[_to_1d_index(pos)] != null


func is_valid_pos(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.y >= 0 and pos.x < _x_max and pos.y < _y_max


func clear():
	_values.fill(null)


#endregion


#region Private static methods
func _to_1d_index(pos: Vector2i) -> int:
	return pos.y * _x_max + pos.x
#endregion
