extends Control
class_name Tooltip

@export var target: BaseButton

@onready var _label: Label = %Label

func _ready() -> void:
	modulate.a = 0.0
	hide()
	
func initialize(text: String) -> void:
	_label.text = text
	size.y = _label.size.y + 8
	
func _fade_in() -> void:
	show()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	
func _fade_out() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.1)
	await tween.finished
	hide()

func _process(_delta: float) -> void:
	if not target:
		return
	if target.is_hovered() and modulate.a == 0.0:
		_fade_in()
	elif not target.is_hovered() and modulate.a == 1.0:
		_fade_out()
