extends AnimatedSprite2D
class_name WeaponView

func _ready() -> void:
	animation = "idle"
	play()

func attack() -> Signal:
	animation = "idle"
	play()
	return animation_finished
