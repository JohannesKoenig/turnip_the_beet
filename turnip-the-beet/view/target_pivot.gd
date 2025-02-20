class_name TargetPivot extends Node2D
@onready var area_2d = $Area2D
var max_distance: float
@onready var collision_shape_2d = $Area2D/CollisionShape2D

func _ready():
	max_distance = (collision_shape_2d.position - position).length()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_global_mouse_position()
	var distance_to_pivot = mouse_position - global_position
	var length = distance_to_pivot.length()
	print(max_distance)
	var target_pos_area_2d = Vector2.RIGHT * min(
		max_distance,
		length
	)
	collision_shape_2d.position = target_pos_area_2d
	look_at(mouse_position)
	
