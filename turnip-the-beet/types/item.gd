class_name Item extends Resource

enum Season {
	SPRING,
	SUMMER,
	FALL,
	WINTER
}

@export var icon: Texture
@export var name: String
@export var price: int
@export var season: Season
@export var description: String
