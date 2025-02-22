class_name StoreSlot extends Control

@onready var item_texture = $ItemTexture
@onready var texture_rect = $TextureRect
@onready var store: Store = Model.store
var x: int
var y: int
var _mouse_inside: bool = false
var item: Item
var selected: bool:
	set(value):
		if selected != value:
			selected = value
			selected_changed.emit()
signal selected_changed(slot: StoreSlot)
signal clicked
var store_state: StoreUi.StoreState

func _ready():
	store.store_changed.connect(_update_slot)
	selected_changed.connect(_on_selected_changed)
	_update_slot()
	_on_selected_changed()


func _update_slot():
	if store.has_value(x, y):
		item = store.get_value(x, y)
		item_texture.texture = item.icon
	else:
		item_texture.texture = null
	
func _make_custom_tooltip(for_text):
	var label = Label.new()
	label.text = "not test"
	return label

func _process(delta):
	if Input.is_action_just_pressed("select"):
		if store_state == StoreUi.StoreState.OPEN:
			if _mouse_inside:
				clicked.emit(self)
	

func _on_mouse_entered():
	_mouse_inside = true


func _on_mouse_exited():
	_mouse_inside = false


func on_store_state_changed(store_state: StoreUi.StoreState):
	self.store_state = store_state
		
func _on_selected_changed():
	if selected:
		texture_rect.modulate = Color.GRAY
	else:
		texture_rect.modulate = Color.BLACK
