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
}

@export var product: Item
@export var seed: Item
@export var name: String
@export var season: Daytime.Season
@export var melodie: Melodie
@export var sound_wave: SoundWave
@export var seed_texture: Texture
@export var small_texture: Texture
@export var large_texture: Texture
@export var ripe_texture: Texture
@export var growing_state: GrowingStateType

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
			return plant
		_:
			return null
			
