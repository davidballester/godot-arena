extends Control
class_name PriceButton

signal pressed()

@export var action: String = "Sell"

@onready var _action_label: Label = %ActionLabel
@onready var _price_tag: Label = %PriceTag
@onready var _button: BaseButton = %Button
@onready var _normal_texture: Control = %NormalTexture
@onready var _pressed_texture: Control = %PressedTexture
@onready var _button_contents: Control = %ButtonContents

var _is_pressed: bool

func _ready() -> void:
	_button.pressed.connect(func(): pressed.emit())
	_button.button_down.connect(func(): _is_pressed = true)
	_button.button_up.connect(func(): _is_pressed = false)
	_action_label.text = action

func initialize(price: int) -> void:
	_price_tag.text = str(price)

func _process(_delta: float) -> void:
	if _is_pressed and _button.is_hovered():
		_button_contents.position.y = 1
		_normal_texture.hide()
		_pressed_texture.show()
	else:
		_button_contents.position.y = 0
		_normal_texture.show()
		_pressed_texture.hide()
