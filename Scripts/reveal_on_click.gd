extends Panel

var revealed: bool = true
@onready var paper_click_audio: AudioStreamPlayer = $'Paper Click'

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
