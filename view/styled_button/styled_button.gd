extends Control
class_name StyledButton

signal pressed()

@export var text: String = "X"

@onready var _label: Label = %Label
@onready var _button: BaseButton = %Button
@onready var _normal_texture: Control = %NormalTexture
@onready var _pressed_texture: Control = %PressedTexture

var _is_pressed: bool

func _ready() -> void:
	_button.pressed.connect(func(): pressed.emit())
	_button.button_down.connect(func(): _is_pressed = true)
	_button.button_up.connect(func(): _is_pressed = false)
	_label.text = text

func _process(_delta: float) -> void:
	if _is_pressed and _button.is_hovered():
		_label.position.y = 1
		_normal_texture.hide()
		_pressed_texture.show()
	else:
		_label.position.y = 0
		_normal_texture.show()
		_pressed_texture.hide()
