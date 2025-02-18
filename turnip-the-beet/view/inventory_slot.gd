class_name InventorySlot extends Control


@onready var texture_rect = $TextureRect
@export var empty_icon: Texture
@onready var inventory: Inventory = Model.inventory
var x: int
var y: int
var _mouse_inside: bool = false
var item: Item

func _ready():
	inventory.inventory_changed.connect(_update_slot)
	_update_slot()


func _update_slot():
	if inventory.has_value(x, y):
		item = inventory.get_value(x, y)
		texture_rect.texture = item.icon
	else:
		texture_rect.texture = empty_icon
	
func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = "not test"
	return label

func _process(delta):
	if Input.is_action_just_pressed("ItemDragging"):
		if _mouse_inside:
			Clipboard.dragging = true
			Clipboard.dragged_item = item
			Clipboard.source_pos = Vector2i(x, y)
			
	if Input.is_action_just_released("ItemDragging"):
		if _mouse_inside:
			if Clipboard.dragged_item != null:
				inventory.delete_value(Clipboard.source_pos.x, Clipboard.source_pos.y)
				inventory.set_value(x, y, Clipboard.dragged_item)
				Clipboard.dragged_item = null
				Clipboard.source_pos = Vector2i(-1, -1)
		
		Clipboard.dragging = false
		
		
			
		

func _on_mouse_entered():
	_mouse_inside = true


func _on_mouse_exited():
	_mouse_inside = false
