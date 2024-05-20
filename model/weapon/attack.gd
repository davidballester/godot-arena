extends Node
class_name Attack

var source: Combatant
var target: Combatant
var damage: int
var source_position: Vector2
var target_position: Vector2
var effect_radius: float
var speed: float

func _init(
	source: Combatant,
	target: Combatant,
	damage: int,
	effect_radius: float = 8,
	speed: float = 999.9
):
	self.source = source
	source_position = source.global_position
	self.target = target
	target_position = target.global_position
	self.effect_radius = effect_radius
	self.speed = speed
	var time_to_land = source_position.distance_to(target_position) / speed
	source.get_tree().create_timer(time_to_land).timeout.connect(func():
		if not _can_affect_target():
			return
		target.take_damage(damage)
	)

func _can_affect_target() -> bool:
	return is_instance_valid(target) and target_position.distance_to(target.global_position) < effect_radius
