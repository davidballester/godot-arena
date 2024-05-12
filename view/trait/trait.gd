extends Control
class_name TraitView

@onready var _trait_name: Label = %TraitName
@onready var _tooltip: Tooltip = %Tooltip

func initialize(traitt: Trait) -> void:
	_trait_name.text = traitt.get_trait_name()
	_tooltip.initialize(traitt.get_description())
