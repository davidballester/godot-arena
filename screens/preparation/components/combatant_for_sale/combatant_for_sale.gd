extends Control
class_name PreparationScreenCombatantForSale

signal bought()

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
	@warning_ignore("narrowing_conversion")
	var price = ceil(combatant.price * Prices.preparation_screen_combatant_for_sale_multiplier)
	_buy_button.initialize(PriceButton.Type.BUY,  price)
	_buy_button.pressed.connect(func(): 
		bought.emit()
		_buy_button.enabled = false
		modulate = Color.from_string("#333333", Color.DIM_GRAY)
	)
