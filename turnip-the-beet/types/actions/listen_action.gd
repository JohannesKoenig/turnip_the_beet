class_name ListenAction extends Action

var _waiting: bool = false
var _finished_waiting: bool = false

static func constructor(position: Vector2) -> ListenAction:
	var action := ListenAction.new()
	action.type = Action.Type.LISTEN
	action.position = position
	return action

func is_finished(pedestrian_entity: PedestrianEntity) -> bool:
	var is_at_target = pedestrian_entity.is_at_target(position)
	var did_we_do_our_special_action = true
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
