class_name UserInterface extends CanvasLayer

@onready var inventory_ui: InventoryUi = $InventoryUi
@onready var store_ui: StoreUi = $StoreUi
@onready var item_display_ui: ItemDisplayUi = $ItemDisplayUi

enum OpenUiType {
	NONE,
	ITEM_DISPLAY,
	INVENTORY,
	STORE
}
var open_ui: OpenUiType:
	set(value):
		if value != open_ui:
			open_ui = value
			open_ui_changed.emit(value)
signal open_ui_changed(type: OpenUiType)

func _ready():
	open_ui_changed.connect(_on_open_ui_changed)

func _process(delta):
	var target_ui: OpenUiType
	var input_set: bool = false
	if Input.is_action_just_pressed("ItemDisplay"):
		target_ui = OpenUiType.ITEM_DISPLAY
		input_set= true
	if Input.is_action_just_pressed("Inventory"):
		target_ui = OpenUiType.INVENTORY
		input_set= true
	if Input.is_action_just_pressed("Store"):
		target_ui = OpenUiType.STORE
		input_set= true
	if Input.is_action_just_pressed("close"):
		target_ui = OpenUiType.NONE
		input_set= true
	
	if !input_set:
		return
	
	if open_ui == target_ui:
		open_ui = OpenUiType.NONE
	else:
		open_ui = target_ui
	

func _on_open_ui_changed(type: OpenUiType):
	inventory_ui.inventory_state = InventoryUi.InventoryState.CLOSED
	store_ui.store_state = StoreUi.StoreState.CLOSED
	item_display_ui.item_display_state = ItemDisplayUi.ItemDisplayState.CLOSED
	match type:
		OpenUiType.ITEM_DISPLAY:
			item_display_ui.item_display_state = ItemDisplayUi.ItemDisplayState.OPEN
		OpenUiType.INVENTORY:
			inventory_ui.inventory_state = InventoryUi.InventoryState.OPEN
		OpenUiType.STORE:
			store_ui.store_state = StoreUi.StoreState.OPEN
