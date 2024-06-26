extends WeaponView
class_name SwordView

const ATTACKS = ["swing", "swing", "thrust"]

func _ready() -> void:
	animated_sprite = %AnimatedSprite2D
	super._ready()

func attack(_attack: Attack) -> void:
	var random_attack = ATTACKS.pick_random()
	match random_attack:
		"swing":
			_swing()
		"thrust":
			_thrust()
			
func _swing() -> void:
	animated_sprite.play("swing")
	var tween: Tween = get_tree().create_tween()
	var initial_rotation_degrees = animated_sprite.rotation_degrees
	tween.tween_property(animated_sprite, "rotation_degrees", initial_rotation_degrees + 145, 0.1)
	tween.tween_property(animated_sprite, "rotation_degrees", initial_rotation_degrees, 0.3)
	await tween.finished
	idle()
			
func _thrust() -> void:
	animated_sprite.play("thrust")
	var tween: Tween = get_tree().create_tween()
	var position_x = animated_sprite.position.x
	var position_y = animated_sprite.position.y
	var initial_rotation_degrees = animated_sprite.rotation_degrees
	tween.tween_property(animated_sprite, "rotation_degrees", initial_rotation_degrees + 90, 0.1)
	tween.tween_property(animated_sprite, "position", Vector2(position_x + 8, position_y), 0.3)
	tween.tween_property(animated_sprite, "position", Vector2(position_x, position_y), 0.3)
	tween.tween_property(animated_sprite, "rotation_degrees", initial_rotation_degrees, 0.1)
	await tween.finished
	idle()
