class_name ItemDisplaySlot extends Control

@onready var item_texture = $ItemTexture
@onready var texture_rect = $TextureRect
@onready var item_display: ItemDisplay = Model.item_display
var x: int
var y: int
var _mouse_inside: bool = false
var item: Item
var selected: bool:
	set(value):
		if selected != value:
			selected = value
			selected_changed.emit()
signal selected_changed(slot: ItemDisplaySlot)
signal clicked
var item_display_state: ItemDisplayUi.ItemDisplayState

func _ready():
	item_display.item_display_changed.connect(_update_slot)
	selected_changed.connect(_on_selected_changed)
	_update_slot()
	_on_selected_changed()


func _update_slot():
	if item_display.has_value(x, y):
		item = item_display.get_value(x, y)
		item_texture.texture = item.icon
	else:
		item_texture.texture = null
	
func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = "not test"
	return label

func _process(delta):
	if Input.is_action_just_pressed("select"):
		if item_display_state == ItemDisplayUi.ItemDisplayState.OPEN:
			if _mouse_inside:
				clicked.emit(self)
	

func _on_mouse_entered():
	_mouse_inside = true


func _on_mouse_exited():
	_mouse_inside = false


func on_item_display_state_changed(item_display_state: ItemDisplayUi.ItemDisplayState):
	self.item_display_state = item_display_state
		
func _on_selected_changed():
	if selected:
		texture_rect.modulate = Color.GRAY
	else:
		texture_rect.modulate = Color.BLACK
