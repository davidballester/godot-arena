extends Control
class_name PreparationScreenCombatantDetails

signal combatant_sold(Combatant)

@onready var _combatant_sprite_thumbnail: CombatantSpriteThumbnail = %CombatantSpriteThumbnail
@onready var _name: Label = %NameDd
@onready var _type: Label = %TypeDd
@onready var _hp: Label = %HPDd
@onready var _weapon: Label = %WeaponDd
@onready var _damage: Label = %DamageDd
@onready var _defense: Label = %DefenseDd
@onready var _sell_button: PriceButton = %SellButton
@onready var _traits: TraitsView = %Traits

var _combatant: Combatant

func _ready() -> void:
	_sell_button.pressed.connect(func(): combatant_sold.emit(_combatant))

func initialize(combatant: Combatant, sell_enabled: bool) -> void:
	_combatant = combatant
	_combatant_sprite_thumbnail.initialize(combatant, true)
	_name.text = combatant.id.capitalize()
	_type.text = combatant.type.capitalize()
	_hp.text = str(combatant.health.max_value)
	var damage_min_max = combatant.get_damage_min_max()
	_damage.text = "{min}-{max}".format({
		"min": str(damage_min_max.min_value),
		"max": str(damage_min_max.max_value)
	})
	_defense.text = str(combatant.get_defense())
	_type.add_theme_color_override("font_color", ColorsData.get_color(combatant.type))
	_weapon.text = combatant.weapon.weapon_name.capitalize()
	_weapon.add_theme_color_override("font_color", ColorsData.get_color(combatant.weapon.weapon_name))
	@warning_ignore("integer_division")
	var sell_price = max(
		1, 
		int(
			ceil(
				combatant.price * Prices.preparation_screen_combatant_sell_multiplier
			)
		)
	)
	_sell_button.initialize(PriceButton.Type.SELL, sell_price)
	_sell_button.enabled = sell_enabled
	_traits.initialize(combatant.traits)
	
