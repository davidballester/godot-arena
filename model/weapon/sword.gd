extends Weapon
class_name Sword

func _ready() -> void:
	damage = MinMax.new()
	damage.min_value = 1
	damage.max_value = 2
	attack_duration_s = 1.0
