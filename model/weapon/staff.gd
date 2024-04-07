extends Weapon
class_name Staff

func _ready() -> void:
	damage = MinMax.new()
	damage.min_value = 1
	damage.max_value = 1
	attack_duration_s = 0.8
	reach = 35
