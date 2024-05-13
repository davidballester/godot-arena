extends Control
class_name TraitView

@onready var _trait_name: Label = %TraitName
@onready var _tooltip: Tooltip = %Tooltip

var _attributes_container: Control
var _dt_template: Label
var _dd_template: Label

func _ready() -> void:
	_attributes_container = _tooltip.content
	_dt_template = _attributes_container.get_node("DtTemplate")
	_dd_template = _attributes_container.get_node("DdTemplate")
	_attributes_container.remove_child(_dt_template)
	_attributes_container.remove_child(_dd_template)

func initialize(traitt: Trait) -> void:
	_trait_name.text = traitt.trait_name
	_remove_attributes()
	if traitt.damage_applied_modifier != 0:
		_add_attribute("Damage: ",  traitt.damage_applied_modifier)
	if traitt.damage_taken_modifier != 0:
		_add_attribute("Defense: ", -traitt.damage_taken_modifier)
		
func _remove_attributes() -> void:
	for child in _attributes_container.get_children():
		child.queue_free()
	
func _add_attribute(label: String, value: int) -> void:
	var dt: Label = _dt_template.duplicate()
	dt.text = label
	_attributes_container.add_child(dt)
	var dd: Label = _dd_template.duplicate()
	dd.text = "%s%s" % ["+" if value > 0 else "", str(value)]
	dd.add_theme_color_override(
		"font_color", 
		Color.from_string("#0095e9", Color.BLUE) if value > 0 else Color.from_string("#ff0044", Color.RED)
	)
	_attributes_container.add_child(dd)
