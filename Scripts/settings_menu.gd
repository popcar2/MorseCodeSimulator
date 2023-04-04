extends CanvasLayer

@onready var morse_speed: int = %'Morse Speed Option'.selected # 2
@onready var letter_time: float = %'Letter Time Spinbox'.value # 0.5
@onready var word_time: float = %'Word Time Spinbox'.value # 1
var long_press_time: float = 0.15

func _ready():
	visible = false
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible

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

func _on_letter_time_spinbox_value_changed(value):
	letter_time = value

func _on_word_time_spinbox_value_changed(value):
	word_time = value

func _on_long_press_time_spinbox_value_changed(value):
	long_press_time = value
