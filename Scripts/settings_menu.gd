extends CanvasLayer

signal debug_mode_changed(activated: bool)
signal pitch_changed(new_pitch: float)
var debug_mode: bool = false

@onready var morse_speed: int = %'Morse Speed Option'.selected # 2
@onready var letter_time: float = %'Letter Time Spinbox'.value # 0.5
@onready var word_time: float = %'Word Time Spinbox'.value # 1
var long_press_time: float = 0.15

@onready var playback_speed: int = %'Morse Playback Option'.selected
@onready var playback_dit_time: float = %'Playback Dit Spinbox'.value
@onready var playback_dah_time: float = %'Playback Dah Spinbox'.value
@onready var playback_letter_time: float = %'Playback Letter Spinbox'.value
@onready var playback_word_time: float = %'Playback Word Spinbox'.value

var morse_sound_pitch: float

func _ready():
	visible = false
	$'Background Panel'.modulate.a = 0
	$'Settings Menu'.modulate.a = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		show_hide_menu()

func show_hide_menu():
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	if visible: 
		tween.tween_property($'Background Panel', "modulate:a", 0, 0.2)
		await tween.tween_property($'Settings Menu', "modulate:a", 0, 0.2).finished
		visible = false
	else:
		visible = true
		tween.tween_property($'Background Panel', "modulate:a", 1, 0.2)
		await tween.tween_property($'Settings Menu', "modulate:a", 1, 0.2).finished

func _on_morse_speed_option_item_selected(index):
	morse_speed = index
	if morse_speed == 0:
		%'Letter Time Spinbox'.value = 2
		%'Word Time Spinbox'.value = 3
		%'Long Press Time Spinbox'.value = 0.15
	elif morse_speed == 1:
		%'Letter Time Spinbox'.value = 1
		%'Word Time Spinbox'.value = 1.5
		%'Long Press Time Spinbox'.value = 0.15
	elif morse_speed == 2:
		%'Letter Time Spinbox'.value = 0.5
		%'Word Time Spinbox'.value = 1
		%'Long Press Time Spinbox'.value = 0.15
	elif morse_speed == 3:
		%'Letter Time Spinbox'.value = 0.25
		%'Word Time Spinbox'.value = 0.5
		%'Long Press Time Spinbox'.value = 0.15
	elif morse_speed == 4:
		%'Letter Time Spinbox'.value = 0.15
		%'Word Time Spinbox'.value = 0.35
		%'Long Press Time Spinbox'.value = 0.10

func _on_morse_playback_option_item_selected(index):
	playback_speed = index
	if playback_speed == 0:
		%'Playback Dit Spinbox'.value = 0.15
		%'Playback Dah Spinbox'.value = 0.45
		%'Playback Letter Spinbox'.value = 0.45
		%'Playback Word Spinbox'.value = 1.05
	elif playback_speed == 1:
		%'Playback Dit Spinbox'.value = 0.10
		%'Playback Dah Spinbox'.value = 0.30
		%'Playback Letter Spinbox'.value = 0.30
		%'Playback Word Spinbox'.value = 0.70
	elif playback_speed == 2:
		%'Playback Dit Spinbox'.value = 0.08
		%'Playback Dah Spinbox'.value = 0.24
		%'Playback Letter Spinbox'.value = 0.24
		%'Playback Word Spinbox'.value = 0.56
	elif playback_speed == 3:
		%'Playback Dit Spinbox'.value = 0.05
		%'Playback Dah Spinbox'.value = 0.15
		%'Playback Letter Spinbox'.value = 0.15
		%'Playback Word Spinbox'.value = 0.35
	elif playback_speed == 4:
		%'Playback Dit Spinbox'.value = 0.04
		%'Playback Dah Spinbox'.value = 0.12
		%'Playback Letter Spinbox'.value = 0.12
		%'Playback Word Spinbox'.value = 0.28

func _on_letter_time_spinbox_value_changed(value):
	letter_time = value

func _on_word_time_spinbox_value_changed(value):
	word_time = value

func _on_long_press_time_spinbox_value_changed(value):
	long_press_time = value

func _on_close_button_pressed():
	show_hide_menu()

func _on_playback_dit_spinbox_value_changed(value):
	playback_dit_time = value

func _on_playback_dah_spinbox_value_changed(value):
	playback_dah_time = value

func _on_playback_letter_spinbox_value_changed(value):
	playback_letter_time = value

func _on_playback_word_spinbox_value_changed(value):
	playback_word_time = value

func _on_debug_mode_button_toggled(button_pressed):
	debug_mode = button_pressed
	debug_mode_changed.emit(debug_mode)

func _on_background_panel_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		show_hide_menu()

func _on_audio_volume_slider_drag_ended(_value_changed):
	SoundManager.play_click_sfx()
	%MorseSoundTest.stop()

func _on_audio_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value * 2))
	if %MorseSoundTest.playing == false:
		%MorseSoundTest.play()

func _on_pitch_slider_drag_ended(_value_changed):
	SoundManager.play_click_sfx()
	%MorseSoundTest.stop()
	
	pitch_changed.emit(%MorseSoundTest.pitch_scale)

func _on_pitch_slider_value_changed(value):
	%MorseSoundTest.pitch_scale = value
	if %MorseSoundTest.playing == false:
		%MorseSoundTest.play()


func _on_donate_button_pressed():
	OS.shell_open("https://ko-fi.com/popcar2")
