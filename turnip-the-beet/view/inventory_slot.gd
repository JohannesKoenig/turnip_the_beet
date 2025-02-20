class_name InventorySlot extends Control

@onready var item_texture = $ItemTexture
@onready var texture_rect = $TextureRect
@onready var inventory: Inventory = Model.inventory
var x: int
var y: int
var _mouse_inside: bool = false
var item: Item
var selected: bool:
	set(value):
		if selected != value:
			selected = value
			selected_changed.emit()
signal selected_changed(slot: InventorySlot)
signal clicked

func _ready():
	inventory.inventory_changed.connect(_update_slot)
	selected_changed.connect(_on_selected_changed)
	_update_slot()
	_on_selected_changed()


func _update_slot():
	if inventory.has_value(x, y):
		item = inventory.get_value(x, y)
		item_texture.texture = item.icon
	else:
		item = null
		item_texture.texture = null
	
func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = "not test"
	return label

func _process(delta):
	if Input.is_action_just_pressed("select"):
		if _mouse_inside:
			clicked.emit(self)
			Clipboard.dragging = true
			Clipboard.dragged_item = item
			Clipboard.source_pos = Vector2i(x, y)
			
	if Input.is_action_just_released("select"):
		if _mouse_inside:
			if Clipboard.dragged_item != null:
				inventory.set_value(Clipboard.source_pos.x, Clipboard.source_pos.y, item)
				inventory.set_value(x, y, Clipboard.dragged_item)
				Clipboard.dragged_item = null
				Clipboard.source_pos = Vector2i(-1, -1)
		
		Clipboard.dragging = false

func _on_mouse_entered():
	_mouse_inside = true


func _on_mouse_exited():
	_mouse_inside = false

func _on_selected_changed():
	if selected:
		texture_rect.modulate = Color.GRAY
	else:
		texture_rect.modulate = Color.BLACK
