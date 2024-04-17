extends TextureButton
class_name SmallButton

@onready var label: Label = %Label

var _is_pressed: bool

func _ready() -> void:
	button_down.connect(func(): _is_pressed = true)
	button_up.connect(func(): _is_pressed = false)

func _process(_delta: float) -> void:
	label.position.y = 0 if not _is_pressed or not is_hovered() else 1
