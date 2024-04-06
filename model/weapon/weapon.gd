extends Node
class_name Weapon

var damage: MinMax
var attack_duration_s: float

func get_damage() -> int:
	return damage.get_random_value()

func wait_attack_duration() -> Signal:
	return get_tree().create_timer(attack_duration_s).timeout
