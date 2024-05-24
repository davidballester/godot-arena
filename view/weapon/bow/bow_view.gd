extends WeaponView
class_name BowView

const ARROW_SCENE_RESOURCE = preload("res://view/weapon/arrow/arrow_view.tscn")
const DELAY_ARROW_LAUNCH_SECONDS = 0.3

var _attacking: bool = false

func _ready() -> void:
	animated_sprite = %AnimatedSprite2D
	super._ready()

func attack(attack: Attack) -> void:
	_attacking = true
	rotation = global_position.angle_to_point(attack.target_global_position)
	animated_sprite.flip_h = rotation < -PI / 2 or rotation > PI / 2
	animated_sprite.play("shooting")
	var arrow: ArrowView = ARROW_SCENE_RESOURCE.instantiate()
	arrow.flip_h = animated_sprite.flip_h
	arrow.ready.connect(func():
		await get_tree().create_timer(DELAY_ARROW_LAUNCH_SECONDS).timeout
		var time_seconds = max(0.25, attack.time_to_land - DELAY_ARROW_LAUNCH_SECONDS)
		arrow.initialize(attack, time_seconds)
	)
	# Using a simple node in between bow and arrow ensures that the arrow won't
	# move when the character moves
	var node = Node.new()
	add_child(node)
	arrow.global_position = Vector2(global_position)
	arrow.rotation = rotation + PI / 2
	node.add_child(arrow)
	await animated_sprite.animation_finished
	idle()
	_attacking = false
	
func face_position(g_position: Vector2) -> void:
	if _attacking:
		return
	super.face_position(g_position)
