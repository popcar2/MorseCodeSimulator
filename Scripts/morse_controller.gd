extends Node

@onready var morse_button: Button = %'Morse Button'
@onready var morse_label: RichTextLabel = %'Morse Label'
@onready var normal_label: RichTextLabel = %'Normal Label'
@onready var reset_button: Button = %'Reset Button'
@onready var hide_button: Button = %'Hide Button'
@onready var play_morse_button: Button = %'Play Morse Button'
@onready var held_timer: Timer = $'Held Timer'
@onready var word_timer: Timer = $'Word Timer'
@onready var letter_timer: Timer = $'Letter Timer'
@onready var morse_audio: AudioStreamPlayer = $'Morse Audio'

var is_held: bool = false
var is_playing_back: bool = false

func _ready():
	morse_button.connect("button_down", _on_morse_button_down)
	morse_button.connect("button_up", _on_morse_button_up)
	word_timer.connect("timeout", _on_word_timer_timeout)
	letter_timer.connect("timeout", _on_letter_timer_timeout)
	reset_button.connect("pressed", reset_label)
	hide_button.connect("toggled", _hide_panel_toggled)
	play_morse_button.connect("toggled", _on_play_morse_button_toggled)

func _input(event):
	if event.is_action_pressed("press_morse"):
		morse_button.emit_signal("button_down")
		morse_button.set_pressed_no_signal(true)
	elif event.is_action_released("press_morse"):
		morse_button.emit_signal("button_up")
		morse_button.set_pressed_no_signal(false)

func _on_morse_button_down():
	if is_held:
		return
	
	held_timer.start(SettingsMenu.letter_time)
	letter_timer.start(SettingsMenu.letter_time)
	word_timer.start(SettingsMenu.word_time)
	morse_audio.play()
	is_held = true
	is_playing_back = false

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
	
	morse_label.text = HelperFunctions.highlight_specific_word(HelperFunctions.strip_bbcode(morse_label.text), -1)
	normal_label.text = HelperFunctions.highlight_specific_letter(
		HelperFunctions.morse_to_text(HelperFunctions.strip_bbcode(morse_label.text)), -1)

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
	is_playing_back = false

func _hide_panel_toggled(toggled: bool):
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	var bottom_panels: Control = %'Bottom Panels'
	if !toggled:
		tween.tween_property(bottom_panels, "position:y", bottom_panels.position.y - 230, 0.65)
		SoundManager.play_maximize_sfx()
	else:
		tween.tween_property(bottom_panels, "position:y", bottom_panels.position.y + 230, 0.65)
		SoundManager.play_minimize_sfx()

func _on_play_morse_button_toggled(_toggled: bool):
	if is_playing_back:
		reset_play_morse_button()
		return
	
	is_playing_back = true
	var word_count: int = 0
	var space_count: int = 0 # For skipping spaces when highlighting letters
	for c in morse_label.text:
		if !is_playing_back:
			reset_play_morse_button()
			return
		
		if c != '|':
			morse_label.text = HelperFunctions.highlight_specific_word(
				HelperFunctions.strip_bbcode(morse_label.text), word_count)
			normal_label.text = HelperFunctions.highlight_specific_letter(
				HelperFunctions.strip_bbcode(normal_label.text), word_count + space_count)
		
		if c == 'E':
			morse_audio.play()
			await get_tree().create_timer(SettingsMenu.playback_dit_time).timeout
			morse_audio.stop()
			await get_tree().create_timer(SettingsMenu.playback_dit_time).timeout
		elif c == 'T':
			morse_audio.play()
			await get_tree().create_timer(SettingsMenu.playback_dah_time).timeout
			morse_audio.stop()
			await get_tree().create_timer(SettingsMenu.playback_dit_time).timeout
		elif c == ' ':
			word_count += 1
			await get_tree().create_timer(SettingsMenu.playback_space_time).timeout
		elif c == '|':
			space_count += 1
			await get_tree().create_timer(SettingsMenu.playback_word_time).timeout
	is_playing_back = false
	morse_label.text = HelperFunctions.strip_bbcode(morse_label.text)
	normal_label.text = HelperFunctions.strip_bbcode(normal_label.text)
	play_morse_button.set_pressed_no_signal(false)

func reset_play_morse_button():
	is_playing_back = false
	morse_label.text = HelperFunctions.strip_bbcode(morse_label.text)
	normal_label.text = HelperFunctions.strip_bbcode(normal_label.text)
	play_morse_button.set_pressed_no_signal(false)
