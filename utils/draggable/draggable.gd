extends BaseButton
class_name Draggable

@export var movable_control: Control

var _last_mouse_position: Vector2
var _is_dragging: bool

func _ready() -> void:
	button_down.connect(func(): 
		_is_dragging = true
		_last_mouse_position = get_viewport().get_mouse_position()
	)
	button_up.connect(func(): _is_dragging = false)

func _process(_delta: float) -> void:
	if not _is_dragging:
		return
	var mouse_position = get_viewport().get_mouse_position()
	var delta = mouse_position - _last_mouse_position
	var new_x = movable_control.global_position.x + delta.x
	var new_y = movable_control.global_position.y + delta.y
	if new_x + size.x > GameGlobals.VIEWPORT_WIDTH:
		new_x = GameGlobals.VIEWPORT_WIDTH - size.x
	if new_y + size.y > GameGlobals.VIEWPORT_HEIGHT:
		new_y = GameGlobals.VIEWPORT_HEIGHT - size.y
	movable_control.global_position = Vector2(
		max(0, new_x),
		max(0, new_y),
	)
	_last_mouse_position = mouse_position
