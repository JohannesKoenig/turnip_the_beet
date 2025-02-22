class_name Pedestrian extends Resource 

var actions: Array[Action]

static func constructor(actions: Array[Action]) -> Pedestrian:
	var pedestrian = Pedestrian.new()
	pedestrian.actions = actions
	return pedestrian
	
	
static func generate_actions(
	spawn_position: Vector2,
	buy_position: Vector2,
	listen_position: Vector2,
	despawn_position: Vector2,
	garden: Garden,
	item_display: ItemDisplay
) -> Array[Action]:
	var actions: Array[Action] = []
	actions.append(LifeCycleAction.constructor(spawn_position))
	var buy = randf() > 0.5
	var listen = randf() > 0.5
	var buy_first = randf() > 0.5
	print(listen, " ", not garden.is_empty())
	print(buy, " ", not item_display.is_empty())
	listen = listen and not garden.is_empty()
	buy = buy and not item_display.is_empty()
	if buy_first:
		if buy: 
			actions.append(BuyAction.constructor(buy_position))
		if listen: 
			actions.append(ListenAction.constructor(listen_position))
	else: 
		if listen: 
			actions.append(ListenAction.constructor(listen_position))
		if buy: 
			actions.append(BuyAction.constructor(buy_position))
	actions.append(LifeCycleAction.constructor(despawn_position))
	
	return actions



	
