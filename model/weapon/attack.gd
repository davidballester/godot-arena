extends Node
class_name Attack

const OFFSET = Vector2(0, - GameGlobals.COMBATANT_HEIGHT / 2)

var source: Combatant
var damage: int
var source_global_position: Vector2
var target_global_position: Vector2
var effect_radius: float
var speed: float
var time_to_land: float

func _init(
	source: Combatant,
	target_global_position: Vector2,
	damage: int,
	effect_radius: float = 8,
	speed: float = 999.9
):
	self.source = source
	source_global_position = Vector2(source.global_position)
	self.target_global_position = Vector2(target_global_position) + OFFSET
	self.effect_radius = effect_radius
	self.speed = speed
	time_to_land = source_global_position.distance_to(target_global_position) / speed
	source.get_tree().create_timer(time_to_land).timeout.connect(func():
		var alive_combatants = source.battle.get_alive_combatants()
		var affected_combatants = alive_combatants.filter(
			func(c): return c != source and self._can_affect_combatant(c)
		)
		affected_combatants.map(func(c: Combatant): c.take_damage(damage))
	)

func _can_affect_combatant(combatant: Combatant) -> bool:
	return target_global_position.distance_to(combatant.global_position + OFFSET) < effect_radius
