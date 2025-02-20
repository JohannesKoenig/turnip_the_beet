class_name EquippedItemSlot extends Control

@onready var item_texture = $ItemTexture
@onready var texture_rect = $TextureRect
@onready var inventory: Inventory = Model.inventory
var x: int
var y: int


func _ready():
	inventory.selected_item_changed.connect(_on_equipped_changed)
	_on_equipped_changed(inventory.selected_item)
	
func _on_equipped_changed(selected: Vector2i):
	var item = inventory.get_value(selected.x, selected.y)
	if item == null:
		item_texture.texture = null
	else:
		item_texture.texture = item.icon
