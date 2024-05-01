extends Control
class_name PreparationScreenCombatantForSale

@onready var _combatant_sprite_thumbnail: CombatantSpriteThumbnail = %CombatantSpriteThumbnail
@onready var _combatant_type_label: Label = %CombatantType
@onready var _buy_button: PriceButton = %BuyButton

func initialize(combatant: Combatant) -> void:
	_combatant_sprite_thumbnail.initialize(combatant, true)
	_combatant_type_label.text = combatant.type.capitalize()
	_combatant_type_label.add_theme_color_override(
		"font_color", 
		ColorsData.get_color(combatant.type)
	)
	_buy_button.initialize(combatant.price)
