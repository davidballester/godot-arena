extends Control
class_name PreparationScreenCombatantThumbnail

const NOT_SELECTED_POPUP_TEXTURE_PATH = preload("res://assets/hud/popup.png")
const SELECTED_POPUP_TEXTURE_PATH = preload("res://assets/hud/popup_highlighted.png")

signal pressed()

var combatant: Combatant

@onready var _combatant_sprite_thumbnail: CombatantSpriteThumbnail = %CombatantSpriteThumbnail
@onready var _combatant_name: Label = %CombatantName
@onready var _combatant_type: Label = %CombatantType
@onready var _button: Button = %Button
@onready var _popup: NinePatchRect = %PopUp

func initialize(
	combatant: Combatant,
) -> void:
	self.combatant = combatant
	_combatant_sprite_thumbnail.initialize(combatant, false)
	_combatant_name.text = combatant.id
	_combatant_type.text = combatant.type.capitalize()
	_combatant_type.add_theme_color_override("font_color", ColorsData.get_color(combatant.type))
	_button.pressed.connect(func(): pressed.emit())

func set_selected(selected: bool) -> void:
	_popup.texture = NOT_SELECTED_POPUP_TEXTURE_PATH if not selected else SELECTED_POPUP_TEXTURE_PATH
