extends Node

@onready var morse_button: Button = %'Morse Button'
@onready var morse_label: RichTextLabel = %'Morse Label'
@onready var normal_label: RichTextLabel = %'Normal Label'
@onready var reset_button: Button = %'Reset Button'
@onready var held_timer: Timer = $'Held Timer'
@onready var word_timer: Timer = $'Word Timer'
@onready var letter_timer: Timer = $'Letter Timer'
@onready var morse_audio: AudioStreamPlayer = $'Morse Audio'

@export var long_press_time: float = 0.15

var is_held: bool = false

func _ready():
	morse_button.connect("button_down", _on_morse_button_down)
	morse_button.connect("button_up", _on_morse_button_up)
	word_timer.connect("timeout", _on_word_timer_timeout)
	letter_timer.connect("timeout", _on_letter_timer_timeout)
	reset_button.connect("pressed", reset_label)

func _input(event):
	if event.is_action_pressed("press_morse"):
		morse_button.emit_signal("button_down")
	elif event.is_action_released("press_morse"):
		morse_button.emit_signal("button_up")

func _on_morse_button_down():
	if is_held:
		return
	
	held_timer.start()
	morse_audio.play()
	word_timer.start()
	letter_timer.start()
	is_held = true

func _on_morse_button_up():
	if !is_held:
		return
	
	var time_left: float = held_timer.time_left
	held_timer.stop()
	if time_left > held_timer.wait_time - long_press_time:
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
