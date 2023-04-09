extends Label

func _ready():
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, 'position:y', position.y - 50, 2)
	await get_tree().create_timer(1).timeout
	var tween2: Tween = create_tween()
	tween2.set_trans(Tween.TRANS_CUBIC)
	tween2.set_ease(Tween.EASE_OUT)
	await tween2.tween_property(self, 'modulate:a', 0, 1).finished
	queue_free()
