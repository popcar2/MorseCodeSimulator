extends Node

@onready var maximizeSFX: AudioStreamPlayer = $MaximizeSFX
@onready var minimizeSFX: AudioStreamPlayer = $MinimizeSFX

func play_maximize_sfx():
	maximizeSFX.play()

func play_minimize_sfx():
	minimizeSFX.play()
