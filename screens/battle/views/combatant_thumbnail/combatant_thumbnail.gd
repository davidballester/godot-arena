extends Button
class_name CombatantThumbnail

@onready var _combatant_sprite: AnimatedSprite2D = %CombatantSprite
@onready var _combatant_name: Label = %CombatantName

var _combatant: Combatant

func initialize(combatant: Combatant) -> void:
	_combatant = combatant
	_combatant_sprite.sprite_frames = combatant.sprite_frames
	_combatant_name.text = _shorten_combatant_name(combatant.id)

func _shorten_combatant_name(combatant_name: String) -> String:
	if combatant_name.length() < 20:
		return combatant_name
	return combatant_name.substr(0, 17) + "..."
	
