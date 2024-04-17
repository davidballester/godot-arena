extends Node
class_name Weapon

var weapon_name: String
var damage: MinMax
var attack_duration_s: float
var reach: float
var sprite_frames: SpriteFrames

func _init(
	weapon_name: String,
	damage: MinMax, 
	attack_duration_s: float, 
	reach: float,
	sprite_frames: SpriteFrames
) -> void:
	self.weapon_name = weapon_name
	self.damage = damage
	self.attack_duration_s = attack_duration_s
	self.reach = reach
	self.sprite_frames = sprite_frames

func get_damage() -> int:
	return damage.get_random_value()

func wait_attack_duration() -> void:
	await get_tree().create_timer(attack_duration_s).timeout
