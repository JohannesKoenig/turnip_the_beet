class_name BuyAction extends Action

var _waiting: bool = false
var _finished_waiting: bool = false

static func constructor(position: Vector2) -> BuyAction:
	var action := BuyAction.new()
	action.type = Action.Type.BUY
	action.position = position
	return action

func is_finished(pedestrian_entity: PedestrianEntity) -> bool:
	var is_at_target = pedestrian_entity.is_at_target(position)
	return is_at_target and _finished_waiting


func process(pedestrian_entity: PedestrianEntity):
	if !pedestrian_entity.is_at_target(position):
		pedestrian_entity.walk_towards(position)
		return
	if !pedestrian_entity.is_waiting() and !_waiting:
		_waiting = true
		pedestrian_entity.wait(3)
		return
	if !pedestrian_entity.is_waiting() and _waiting:
		_finished_waiting = true
		var bought = false
		var item_display = Model.item_display
		for y in range(item_display.data._y_max):
			for x in range(item_display.data._x_max):
				if item_display.has_value(x, y):
					var item = item_display.get_value(x, y)
					item_display.delete_value(x, y)
					Model.money.gain(item.price)
					bought = true
					break
			if bought:
				break
