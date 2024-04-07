extends AnimatedSprite2D
class_name DeadIcon

func _ready() -> void:
	modulate.a = 0

func display() -> void:
	var opacity_tween = get_tree().create_tween()
	opacity_tween.tween_property(self, "modulate:a", 0.5, 0.6)
	opacity_tween.tween_property(self, "modulate:a", 0, 0.6)
	var offset_tween = get_tree().create_tween()
	offset_tween.tween_property(self, "offset:y", -30, 1.2)
	await offset_tween.finished
	offset.y = 0
