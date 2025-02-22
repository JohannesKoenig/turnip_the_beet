class_name Item extends Resource

enum Type {
	SEED,
	PRODUCT,
}
@export var icon: Texture
@export var name: String
@export var price: int
@export var season: Daytime.Season
@export var description: String
@export var species: Plant.Species
@export var item_type: Type
