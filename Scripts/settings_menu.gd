extends CanvasLayer

signal debug_mode_changed(activated: bool)
var debug_mode: bool = false

@onready var morse_speed: int = %'Morse Speed Option'.selected # 2
@onready var letter_time: float = %'Letter Time Spinbox'.value # 0.5
@onready var word_time: float = %'Word Time Spinbox'.value # 1
var long_press_time: float = 0.15

# TODO: Make options for these variables and hook it up with morse_controller
@onready var playback_speed: int = %'Morse Playback Option'.selected
@onready var playback_dit_time: float = %'Playback Dit Spinbox'.value
@onready var playback_dah_time: float = %'Playback Dah Spinbox'.value
@onready var playback_space_time: float = %'Playback Space Spinbox'.value
@onready var playback_word_time: float = %'Playback Word Spinbox'.value

func _ready():
	visible = false
	$'Background Panel'.modulate.a = 0
	$'Settings Menu'.modulate.a = 0
	pass

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
		%'Letter Time Spinbox'.value = 2.5
		%'Word Time Spinbox'.value = 4
		%'Long Press Time Spinbox'.value = 0.15
	elif morse_speed == 1:
		%'Letter Time Spinbox'.value = 2
		%'Word Time Spinbox'.value = 3
		%'Long Press Time Spinbox'.value = 0.15
	elif morse_speed == 2:
		%'Letter Time Spinbox'.value = 1
		%'Word Time Spinbox'.value = 2
		%'Long Press Time Spinbox'.value = 0.15
	elif morse_speed == 3:
		%'Letter Time Spinbox'.value = 0.5
		%'Word Time Spinbox'.value = 1
		%'Long Press Time Spinbox'.value = 0.15
	elif morse_speed == 4:
		%'Letter Time Spinbox'.value = 0.3
		%'Word Time Spinbox'.value = 0.75
		%'Long Press Time Spinbox'.value = 0.10

func _on_morse_playback_option_item_selected(index):
	playback_speed = index
	if playback_speed == 0:
		%'Playback Dit Spinbox'.value = 0.2
		%'Playback Dah Spinbox'.value = 0.6
		%'Playback Space Spinbox'.value = 1
		%'Playback Word Spinbox'.value = 2.5
	elif playback_speed == 1:
		%'Playback Dit Spinbox'.value = 0.1
		%'Playback Dah Spinbox'.value = 0.3
		%'Playback Space Spinbox'.value = 0.5
		%'Playback Word Spinbox'.value = 1.25
	elif playback_speed == 2:
		%'Playback Dit Spinbox'.value = 0.07
		%'Playback Dah Spinbox'.value = 0.21
		%'Playback Space Spinbox'.value = 0.35
		%'Playback Word Spinbox'.value = 1
	elif playback_speed == 3:
		%'Playback Dit Spinbox'.value = 0.05
		%'Playback Dah Spinbox'.value = 0.15
		%'Playback Space Spinbox'.value = 0.20
		%'Playback Word Spinbox'.value = 0.5
	elif playback_speed == 4:
		%'Playback Dit Spinbox'.value = 0.04
		%'Playback Dah Spinbox'.value = 0.12
		%'Playback Space Spinbox'.value = 0.15
		%'Playback Word Spinbox'.value = 0.30

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

func _on_playback_space_spinbox_value_changed(value):
	playback_space_time = value

func _on_playback_word_spinbox_value_changed(value):
	playback_word_time = value

func _on_debug_mode_button_toggled(button_pressed):
	debug_mode = button_pressed
	debug_mode_changed.emit(debug_mode)
