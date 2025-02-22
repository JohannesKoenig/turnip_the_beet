class_name Plant extends Resource

enum GrowingStateType {
	SEED,
	SMALL,
	LARGE,
	RIPE,
}

enum Species {
	NONE,
	TOMATO,
	CARROT,
}

@export var product: Item
@export var seed: Item
@export var name: String
@export var season: Daytime.Season
@export var midi_file: String
@export var sound_wave: SoundWave
var melodie: Melodie
@export var seed_texture: Texture
@export var small_texture: Texture
@export var large_texture: Texture
@export var ripe_texture: Texture
@export var growing_state: GrowingStateType

@export var seed_to_small: int = 1
@export var small_to_large: int = 1
@export var large_to_ripe: int = 1

func get_texture()-> Texture:
	match growing_state:
		GrowingStateType.SEED: 
			return seed_texture
		GrowingStateType.SMALL: 
			return small_texture
		GrowingStateType.LARGE:
			return large_texture
		GrowingStateType.RIPE:
			return ripe_texture
		_: return null

static func constructor(species: Species) -> Plant:
	match species:
		Species.TOMATO:
			var plant = load("res://types/plants/tomato_plant.tres").duplicate()
			plant.melodie = Melodie.load_melodie(plant.midi_file)
			return plant
		Species.CARROT:
			var plant = load("res://types/plants/carrot_plant.tres").duplicate()
			plant.melodie = Melodie.load_melodie(plant.midi_file)
			return plant
		_:
			return null
			
