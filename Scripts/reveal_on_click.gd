extends Panel

var revealed: bool = true
@onready var paper_click_audio: AudioStreamPlayer = $'Paper Click'
@onready var panel_theme: StyleBoxFlat = get_theme_stylebox('panel').duplicate()

func _ready():
	panel_theme.border_color = Color('10c595')
	panel_theme.border_width_left = 50
	panel_theme.border_width_top = 46
	panel_theme.border_width_right = 50
	panel_theme.border_width_bottom = 50
	add_theme_stylebox_override('panel', panel_theme)

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		toggle_reveal()

func toggle_reveal():
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_parallel(true)
	if revealed:
		tween.tween_property(self, "position:y", 355, 1)
		tween.tween_property(self, "rotation_degrees", 15, 1)
	else:
		tween.tween_property(self, "position:y", 15, 1)
		tween.tween_property(self, "rotation_degrees", 0, 1)
	revealed = !revealed
	if revealed:
		paper_click_audio.pitch_scale = 1
	else:
		paper_click_audio.pitch_scale = 0.9
	paper_click_audio.play()


func _on_mouse_entered():
	panel_theme.expand_margin_left = 7
	panel_theme.expand_margin_bottom = 7
	panel_theme.expand_margin_right = 7
	panel_theme.expand_margin_top = 7

func _on_mouse_exited():
	panel_theme.expand_margin_left = 0
	panel_theme.expand_margin_bottom = 0
	panel_theme.expand_margin_right = 0
	panel_theme.expand_margin_top = 0
