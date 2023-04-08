extends Node

@onready var maximizeSFX: AudioStreamPlayer = $MaximizeSFX
@onready var minimizeSFX: AudioStreamPlayer = $MinimizeSFX
@onready var clickSFX: AudioStreamPlayer = $ClickSFX

func _ready():
	for button in get_tree().get_nodes_in_group('button click'):
		button.connect('pressed', play_click_sfx)

func play_maximize_sfx():
	maximizeSFX.play()

func play_minimize_sfx():
	minimizeSFX.play()

func play_click_sfx():
	clickSFX.pitch_scale = randf_range(0.9, 1.1)
	clickSFX.play()
