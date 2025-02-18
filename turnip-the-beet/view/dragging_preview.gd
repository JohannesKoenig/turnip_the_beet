class_name DraggingPreview extends TextureRect

func _process(delta):
	position = get_viewport().get_mouse_position()
	if Clipboard.dragging:
		visible = true
		var item = Clipboard.dragged_item
		if item != null:
			texture = item.icon
	else:
		visible = false
		texture = null
