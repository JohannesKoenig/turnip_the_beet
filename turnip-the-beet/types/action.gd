class_name Action extends Resource 


enum Type{
	LIFE_CYCLE,
	BUY, 
	LISTEN,

}

var type: Type 
var position: Vector2

func is_finished(pedestrian_entity: PedestrianEntity) -> bool:
	return false

func process(pedestrian_entity: PedestrianEntity):
	return
