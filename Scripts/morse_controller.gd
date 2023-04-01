extends Node

@onready var morse_button: Button = %'Morse Button'
@onready var morse_label: RichTextLabel = %'Morse Label'
@onready var reset_button: Button = %'Reset Button'
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

func _on_morse_button_down():
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
	if time_left > 0.85:
		morse_label.append_text('E')
	else:
		morse_label.append_text('T')
	morse_audio.stop()
	is_held = false

func _on_word_timer_timeout():
	if !is_held:
		morse_label.append_text('|')

func _on_letter_timer_timeout():
	if is_held:
		_on_morse_button_up()
	else:
		morse_label.append_text(' ')

func reset_label():
	morse_label.clear()

func morse_to_text():
	pass
