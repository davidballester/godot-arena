extends Node
class_name Weapon

var damage: MinMax
var attack_duration_s: float
var reach: float

func _init(damage: MinMax, attack_duration_s: float, reach: float) -> void:
	self.damage = damage
	self.attack_duration_s = attack_duration_s
	self.reach = reach

func get_damage() -> int:
	return damage.get_random_value()

func wait_attack_duration() -> void:
	await get_tree().create_timer(attack_duration_s).timeout
