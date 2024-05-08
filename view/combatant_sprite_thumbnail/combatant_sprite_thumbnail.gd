extends MarginContainer
class_name CombatantSpriteThumbnail

@onready var _combatant_sprite: AnimatedSprite2D = %CombatantSprite
@onready var _weapon_sprite: AnimatedSprite2D = %WeaponSprite

func initialize(combatant: Combatant, animated: bool) -> void:
	_combatant_sprite.sprite_frames = combatant.sprite_frames
	if animated:
		play("idle")
	_weapon_sprite.sprite_frames = combatant.weapon.sprite_frames

func play(animation: String) -> void:
	_combatant_sprite.speed_scale = 1.0
	_combatant_sprite.play(animation)

func play_first_frame(animation: String) -> void:
	_combatant_sprite.speed_scale = 0
	_combatant_sprite.play(animation)
