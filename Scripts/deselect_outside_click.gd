extends TextEdit

var is_focused: bool = false

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		var evLocal = make_input_local(event)
		if !Rect2(Vector2(0,0), size).has_point(evLocal.position):
			is_focused = false
			release_focus()
		else:
			is_focused = true
