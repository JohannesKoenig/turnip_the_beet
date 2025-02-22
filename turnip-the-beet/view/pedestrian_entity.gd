class_name PedestrianEntity extends Node2D

var pedestrian: Pedestrian
var target_position: Vector2
var current_action: int
var actions: Array[Action]
var max_speed: float = 1
var wait_until: float
@onready var gpu_particles_2d = $GPUParticles2D
var listening: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	actions = pedestrian.actions
	current_action = 0
	gpu_particles_2d.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if listening:
		gpu_particles_2d.emitting = true
	else:
		gpu_particles_2d.emitting = false
	if current_action < len(actions):
		var action = actions[current_action]
		action.process(self)
		if action.is_finished(self):
			current_action += 1
	else:
		queue_free()

func _physics_process(delta):
	var lerped_position = lerp(position, target_position, delta * 10)
	var lerped_speed = (lerped_position - position).length()
	var direction = (lerped_position - position).normalized()
	var normalized_target = position + direction * min(max_speed, lerped_speed)
	position = normalized_target

func walk_towards(target: Vector2):
	target_position = target
	
func is_at_target(target: Vector2) -> bool:
	return (position - target).length() < 0.1

func wait(time: float):
	wait_until = Time.get_unix_time_from_system() + time

func is_waiting() -> bool:
	return Time.get_unix_time_from_system() < wait_until

func listen(value: bool):
	listening = value
