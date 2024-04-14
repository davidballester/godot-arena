extends Node2D
class_name CombatantView

const DUST_ANIMATIONS = ["death", "hit", "roll", "run", "idle"]

@onready var combatant: AnimatedSprite2D = %Combatant
@onready var dust: AnimatedSprite2D = %Dust
@onready var damage_label: DamageLabel = %DamageLabel
@onready var dead_icon: DeadIcon = %DeadIcon
@onready var health_bar: HealthBar = %HealthBar
var flip_h: bool:
	set(val):
		combatant.flip_h = val
		dust.flip_h = val

func initialize(
	sprite_frames: SpriteFrames, 
	dust_sprite_frames: SpriteFrames,
	health: Gauge
) -> void:
	combatant.sprite_frames = sprite_frames
	dust.sprite_frames = dust_sprite_frames
	health_bar.initialize(health)
	idle()
	
func idle() -> void:
	await _play_animation("idle")

func die() -> void:
	dead_icon.flip_h = combatant.flip_h
	dead_icon.display()
	await _play_animation("death")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	await tween.finished
	
func hit(damage: int) -> void:
	var prev_animation = combatant.animation
	damage_label.show_damage(damage)
	await _play_animation("hit")
	_play_animation(prev_animation)
	
func roll() -> void:
	var prev_animation = combatant.animation
	await _play_animation("roll")
	await _play_animation(prev_animation)
	
func start_running() -> void:
	_play_animation("run")
	
func stop_running() -> void:
	_play_animation("idle")
	
func turn(play_backwards: bool = false) -> void:
	var prev_animation = combatant.animation
	await _play_animation("turn", play_backwards)
	_play_animation(prev_animation)
	
func _play_animation(animation_name: String, play_backwards: bool = false) -> void:
	var custom_speed = 1.0 if not play_backwards else -1.0
	combatant.play(animation_name, custom_speed, play_backwards)
	var dust_animation_name = animation_name if DUST_ANIMATIONS.has(animation_name) else "idle"
	dust.play(dust_animation_name)
	await combatant.animation_finished
	if animation_name == "death":
		dust.play("idle")
