class_name PlantEntity extends Node2D

@export var plant: Plant
@onready var sprite_2d = $SpriteRig/Sprite2D
@onready var melodie_player = $MelodiePlayer
@onready var synthesizer = $Synthesizer
@onready var animation_player = $AnimationPlayer
@onready var gpu_particles_2d = $GPUParticles2D



# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = plant.get_texture()
	melodie_player.melodie = plant.melodie
	synthesizer.sound_wave = plant.sound_wave
	if plant.growing_state == Plant.GrowingStateType.RIPE:
		gpu_particles_2d.emitting = true
	else:
		gpu_particles_2d.emitting = false
	Metronome.new_tick.connect(on_new_tick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_new_tick(tact: int, tick: int):
	if plant.growing_state == Plant.GrowingStateType.SEED:
		return
	if tick %8 != 1: 
		return
	animation_player.stop()
	animation_player.play("bob")
