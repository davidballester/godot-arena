extends WeaponView
class_name BowView

var _attacking: bool = false

func _ready() -> void:
	animated_sprite = %AnimatedSprite2D
	super._ready()

func attack(attack: Attack) -> void:
	_attacking = true
	rotation = global_position.angle_to_point(attack.target.global_position)
	animated_sprite.play("shooting")
	await animated_sprite.animation_finished
	idle()
	_attacking = false
	
func face_position(g_position: Vector2) -> void:
	if _attacking:
		return
	super.face_position(g_position)
