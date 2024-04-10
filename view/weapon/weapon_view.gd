extends Node2D
class_name WeaponView

var animated_sprite: AnimatedSprite2D

func _ready() -> void:
	idle()

# virtual
func attack() -> void:
	await get_tree().create_timer(0.1).timeout
	pass
	
func face_position(g_position: Vector2) -> void:
	if g_position.x > global_position.x:
		rotation = global_position.angle_to_point(g_position)  
	else: 
		rotation = g_position.angle_to_point(global_position)

func idle() -> void:
	animated_sprite.play("idle")

