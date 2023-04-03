extends Control

@onready var morse_button: Button = %'Morse Button'
@onready var long_press_progressbar: ProgressBar = %'LongPressProgressBar'
@onready var letter_progressbar: ProgressBar = %'LetterProgressBar'
@onready var word_progressbar: ProgressBar = %'WordProgressBar'

@onready var morse_controller: Node = %'Morse Controller'
@onready var long_press_time: float = morse_controller.long_press_time
@onready var letter_time: float = morse_controller.letter_timer.wait_time
@onready var word_time: float = morse_controller.word_timer.wait_time

var tweens: Array[Tween]

func _ready():
	morse_button.connect("button_down", _on_morse_button_down)
	morse_button.connect("button_up", _on_morse_button_up)
	tweens.resize(3)

func _on_morse_button_down():
	begin_tween(long_press_progressbar, 0, Color.RED, long_press_time)
	begin_tween(letter_progressbar, 1, Color.WHITE, letter_time, true)
	begin_tween(word_progressbar, 2, Color.WHITE, word_time, true)

func _on_morse_button_up():
	end_tween(long_press_progressbar, 0, Color.WHITE)

func begin_tween(progressbar: ProgressBar, idx: int, color: Color, time: float, reset: bool = false):
	if tweens[idx] and tweens[idx].is_running():
		tweens[idx].kill()
	
	progressbar.value = 0
	tweens[idx] = create_tween()
	await tweens[idx].tween_property(progressbar, "value", 100, time).finished
	if reset:
		progressbar.value = 0
	else:
		if progressbar.value == 100:
			progressbar.modulate = color

func end_tween(progressbar: ProgressBar, idx: int, end_color: Color):
	progressbar.modulate = end_color
	if tweens[idx] and tweens[idx].is_running():
		tweens[idx].kill()
	
	long_press_progressbar.value = 0
