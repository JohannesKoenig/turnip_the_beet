class_name LifeCycleAction extends Action



static func constructor(position: Vector2) -> LifeCycleAction:
	var action := LifeCycleAction.new()
	action.type = Action.Type.LIFE_CYCLE
	action.position = position
	return action

func is_finished(pedestrian_entity: PedestrianEntity) -> bool:
	var is_at_target = pedestrian_entity.is_at_target(position)
	var did_we_do_our_special_action = true
	return is_at_target and did_we_do_our_special_action


func process(pedestrian_entity: PedestrianEntity):
	if !pedestrian_entity.is_at_target(position):
		pedestrian_entity.walk_towards(position)
		return
	# do something special
	return
