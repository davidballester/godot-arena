extends Control
class_name PreparationScreenCombatantThumbnail

@onready var _combatant_weapon_sprite: AnimatedSprite2D = %CombatantWeaponSprite
@onready var _combatant_sprite: AnimatedSprite2D = %CombatantSprite
@onready var _combatant_name: Label = %CombatantName
@onready var _combatant_type: Label = %CombatantType
@onready var _combatant_weapon: Label = %CombatantWeapon

func initialize(
	combatant: Combatant,
) -> void:
	_combatant_sprite.sprite_frames = combatant.sprite_frames
	_combatant_name.text = combatant.id
	_combatant_type.text = combatant.type.capitalize()
	_combatant_type.add_theme_color_override("font_color", ColorsData.get_color(combatant.type))
	_combatant_weapon_sprite.sprite_frames = combatant.weapon.sprite_frames
	_combatant_weapon.text = combatant.weapon.weapon_name.capitalize()
	_combatant_weapon.add_theme_color_override(
		"font_color", 
		ColorsData.get_color(combatant.weapon.weapon_name)
	)
