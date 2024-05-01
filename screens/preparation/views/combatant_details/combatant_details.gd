extends Control
class_name PreparationScreenCombatantDetails

@onready var _combatant_sprite: AnimatedSprite2D = %CombatantSprite
@onready var _weapon_sprite: AnimatedSprite2D = %WeaponSprite
@onready var _name: Label = %NameDd
@onready var _type: Label = %TypeDd
@onready var _hp: Label = %HPDd
@onready var _weapon: Label = %WeaponDd
@onready var _damage: Label = %DamageDd
@onready var _sell_button: SellButton = %SellButton

func initialize(combatant: Combatant) -> void:
	_combatant_sprite.sprite_frames = combatant.sprite_frames
	_combatant_sprite.play("idle")
	_weapon_sprite.sprite_frames = combatant.weapon.sprite_frames
	_name.text = combatant.id.capitalize()
	_type.text = combatant.type.capitalize()
	_hp.text = str(combatant.health.max_value)
	_damage.text = "{min}-{max}".format({
		"min": str(combatant.weapon.damage.min_value),
		"max": str(combatant.weapon.damage.max_value)
	})
	_type.add_theme_color_override("font_color", ColorsData.get_color(combatant.type))
	_weapon.text = combatant.weapon.weapon_name.capitalize()
	_weapon.add_theme_color_override("font_color", ColorsData.get_color(combatant.weapon.weapon_name))
	@warning_ignore("integer_division")
	var sell_price = int(floor(combatant.price / 2))
	_sell_button.initialize(sell_price)
