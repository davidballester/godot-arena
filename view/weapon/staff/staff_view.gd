extends WeaponView
class_name StaffView

func _ready() -> void:
	animated_sprite = %AnimatedSprite2D
	super._ready()

func attack(_attack: Attack) -> void:
	animated_sprite.play("swing")
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(animated_sprite, "rotation_degrees", 145, 0.1)
	tween.tween_property(animated_sprite, "rotation_degrees", 0, 0.3)
	await tween.finished
	idle()
