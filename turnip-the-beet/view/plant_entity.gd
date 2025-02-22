class_name PlantEntity extends Node2D

@export var plant: Plant
@onready var sprite_2d = $SpriteRig/Sprite2D
@onready var melodie_player = $MelodiePlayer
@onready var synthesizer = $Synthesizer
@onready var animation_player = $AnimationPlayer
@onready var gpu_particles_2d = $GPUParticles2D
@onready var interactable_pop_up = $InteractablePopUp
var _player_target_inside: bool = false

var x: int
var y: int
var reached_growing_state: int
var daytime: Daytime
var garden: Garden
var inventory: Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	garden = Model.garden
	inventory = Model.inventory
	daytime = Model.daytime
	reached_growing_state = daytime.day
	daytime.day_changed.connect(on_day_changed)
	update_plant()
	Metronome.new_tick.connect(on_new_tick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _player_target_inside and _can_harvest():
		interactable_pop_up.visible = true
		if Input.is_action_just_pressed("interact"):
			if inventory.has_space():
				garden.delete_value(x, y)
				inventory.add_value(plant.product)
				queue_free()
	else:
		interactable_pop_up.visible = false

func on_day_changed(day:int):
	var delta = day - reached_growing_state
	var growing_state = plant.growing_state
	var duration = INF
	match growing_state:
		Plant.GrowingStateType.SEED:
			duration = plant.seed_to_small
		Plant.GrowingStateType.SMALL:
			duration = plant.small_to_large
		Plant.GrowingStateType.LARGE:
			duration = plant.large_to_ripe
		Plant.GrowingStateType.RIPE:
			duration = INF

	if delta >= duration:
		plant.growing_state += 1
		reached_growing_state = day
		update_plant()

func update_plant():
	sprite_2d.texture = plant.get_texture()
	melodie_player.melodie = plant.melodie
	synthesizer.sound_wave = plant.sound_wave
	if plant.growing_state == Plant.GrowingStateType.RIPE:
		gpu_particles_2d.emitting = true
	else:
		gpu_particles_2d.emitting = false

func on_new_tick(tact: int, tick: int):
	if plant.growing_state == Plant.GrowingStateType.SEED:
		return
	if tick %8 != 1: 
		return
	animation_player.stop()
	animation_player.play("bob")

func _can_harvest() -> bool:
	return plant.growing_state == Plant.GrowingStateType.RIPE


func _on_area_2d_area_entered(area):
	_player_target_inside = true


func _on_area_2d_area_exited(area):
	_player_target_inside = false
