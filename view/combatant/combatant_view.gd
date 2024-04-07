extends Node2D
class_name CombatantView

const DUST_ANIMATIONS = ["death", "hit", "roll", "run", "idle"]

@onready var combatant: AnimatedSprite2D = %Combatant
@onready var dust: AnimatedSprite2D = %Dust
var sprite_frames: SpriteFrames
var flip_h: bool:
	set(val):
		combatant.flip_h = val
		dust.flip_h = val

func initialize() -> void:
	combatant.sprite_frames = sprite_frames
	idle()
	
func idle() -> void:
	await _play_animation("idle")

func die() -> void:
	await _play_animation("death")
	
func hit() -> void:
	await _play_animation("hit")
	_play_animation("idle")
	
func roll() -> void:
	await _play_animation("roll")
	await _play_animation("idle")
	
func start_running() -> void:
	_play_animation("run")
	
func stop_running() -> void:
	_play_animation("idle")
	
func turn() -> void:
	await _play_animation("turn")
	_play_animation("idle")
	
func _play_animation(animation_name: String) -> void:
	combatant.play(animation_name)
	var dust_animation_name = animation_name if DUST_ANIMATIONS.has(animation_name) else "idle"
	print("_play_animation ", dust_animation_name)
	dust.play(dust_animation_name)
	await combatant.animation_finished
