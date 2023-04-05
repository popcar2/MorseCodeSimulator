extends Node

@onready var morse_button: Button = %'Morse Button'
@onready var morse_label: RichTextLabel = %'Morse Label'
@onready var normal_label: RichTextLabel = %'Normal Label'
@onready var reset_button: Button = %'Reset Button'
@onready var hide_button: Button = %'Hide Button'
@onready var held_timer: Timer = $'Held Timer'
@onready var word_timer: Timer = $'Word Timer'
@onready var letter_timer: Timer = $'Letter Timer'
@onready var morse_audio: AudioStreamPlayer = $'Morse Audio'

var is_held: bool = false

func _ready():
	morse_button.connect("button_down", _on_morse_button_down)
	morse_button.connect("button_up", _on_morse_button_up)
	word_timer.connect("timeout", _on_word_timer_timeout)
	letter_timer.connect("timeout", _on_letter_timer_timeout)
	reset_button.connect("pressed", reset_label)
	hide_button.connect("toggled", _hide_panel_toggled)

func _input(event):
	if event.is_action_pressed("press_morse"):
		morse_button.emit_signal("button_down")
	elif event.is_action_released("press_morse"):
		morse_button.emit_signal("button_up")

func _on_morse_button_down():
	if is_held:
		return
	
	held_timer.start(SettingsMenu.letter_time)
	letter_timer.start(SettingsMenu.letter_time)
	word_timer.start(SettingsMenu.word_time)
	morse_audio.play()
	is_held = true

func _on_morse_button_up():
	if !is_held:
		return
	
	var time_left: float = held_timer.time_left
	held_timer.stop()
	if time_left > held_timer.wait_time - SettingsMenu.long_press_time:
		morse_label.text += 'E'
	else:
		morse_label.text += 'T'
	morse_audio.stop()
	is_held = false
	
	morse_label.text = HelperFunctions.highlight_last_word(HelperFunctions.strip_bbcode(morse_label.text))
	normal_label.text = HelperFunctions.highlight_last_letter(
		HelperFunctions.morse_to_text(HelperFunctions.strip_bbcode(morse_label.text)))

func _on_word_timer_timeout():
	if !is_held:
		morse_label.text += '|'

func _on_letter_timer_timeout():
	if is_held:
		_on_morse_button_up()
	morse_label.text += ' '
	morse_label.text = HelperFunctions.strip_bbcode(morse_label.text)
	normal_label.text = HelperFunctions.strip_bbcode(normal_label.text)

func reset_label():
	morse_label.text = ''
	normal_label.text = ''
	letter_timer.stop()
	word_timer.stop()

func _hide_panel_toggled(toggled: bool):
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	if !toggled:
		tween.tween_property(%'Bottom Panels', "position:y", 0, 1)
	else:
		tween.tween_property(%'Bottom Panels', "position:y", 230, 1)
