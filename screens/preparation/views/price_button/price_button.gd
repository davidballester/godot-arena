extends Control
class_name PriceButton

enum Type { 
	BUY,
	SELL
}

signal pressed()

@export var action: String = "Sell"

@onready var _action_label: Label = %ActionLabel
@onready var _price_tag: Label = %PriceTag
@onready var _button: BaseButton = %Button
@onready var _normal_texture: Control = %NormalTexture
@onready var _pressed_texture: Control = %PressedTexture
@onready var _disabled_texture: Control = %DisabledTexture
@onready var _button_contents: Control = %ButtonContents

var _is_pressed: bool
var _price: int = 0
var _type: Type = Type.SELL

func _ready() -> void:
	_button.button_down.connect(func(): _is_pressed = true)
	_button.button_up.connect(func(): _is_pressed = false)
	_action_label.text = action

func initialize(type: Type, price: int) -> void:
	_price = price
	_type = type
	_price_tag.text = str(price)
	_button.pressed.connect(func():
		match type:
			Type.BUY:
				if not GameGlobals.budget.can_afford(price):
					return
				GameGlobals.budget.take_from_budget(price)
			Type.SELL:
				GameGlobals.budget.add_to_budget(price)
		pressed.emit()
	)
	
func _process(_delta: float) -> void:
	if _type == Type.BUY and not GameGlobals.budget.can_afford(_price):
		_normal_texture.hide()
		_pressed_texture.hide()
		_disabled_texture.show()
		return
		
	_disabled_texture.hide()
	if _is_pressed and _button.is_hovered():
		_button_contents.position.y = 1
		_normal_texture.hide()
		_pressed_texture.show()
	else:
		_button_contents.position.y = 0
		_normal_texture.show()
		_pressed_texture.hide()
