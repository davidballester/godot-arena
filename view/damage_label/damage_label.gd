extends Label
class_name DamageLabel

func _ready() -> void:
	hide()

func show_damage(damage: int) -> void:
	text = str(damage)
	show()
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "offset_top", -15, 1.0)
	tween.tween_property(self, "modulate:a", 0, 1.0)
	await tween.finished
	offset_top = 0
	modulate.a = 1.0
	hide()
