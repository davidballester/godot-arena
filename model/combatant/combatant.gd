extends Node2D
class_name Combatant

signal defeated()

var id: String
var type: String
var team_id: String
var speed: float = 40.0
var weapon: Weapon
var brain: Brain
var state_machine: CombatantStateMachine
var health: Gauge
var battle: Battle
var sprite_frames: SpriteFrames
var dust_sprite_frames: SpriteFrames
var price: int
var traits: Array

var _inmune: bool = false
var _inmune_time_s: MinMaxFloat = MinMaxFloat.create(0.6, 1.3)

func _init(
	id: String,
	type: String,
	battle: Battle,
	team_id: String,
	speed: float,
	weapon: Weapon,
	brain: Brain,
	health: Gauge,
	price: int,
	sprite_frames: SpriteFrames,
	dust_sprite_frames: SpriteFrames,
	traits: Array = []
) -> void:
	self.id = id
	self.type = type
	self.team_id = team_id
	self.speed = speed
	self.weapon = weapon
	self.brain = brain
	self.brain.initialize(self)
	self.health = health
	self.battle = battle
	self.price = price
	self.sprite_frames = sprite_frames
	self.dust_sprite_frames = dust_sprite_frames
	self.traits = traits
	state_machine = CombatantStateMachine.new(self, battle)
	state_machine.id = id + "state_machine"
	state_machine.add_child(CombatantApproachEnemyState.new())
	state_machine.add_child(CombatantEngageEnemyState.new())
	state_machine.add_child(CombatantEscapeState.new())
	state_machine.add_child(CombatantSeekEnemyState.new())
	state_machine.add_child(CombatantVictoryState.new())
	state_machine.add_child(CombatantDeadState.new())
	state_machine.add_child(CombatantHitState.new())
	add_child(state_machine)
	if battle:
		state_machine.initialize()
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
	health.minimum_reached.connect(func(): defeated.emit())

func is_alive() -> bool:
	return health.current_value > 0
	
func get_damage_min_max() -> MinMax:
	var damage_modifier = traits.reduce(
		func(modifier, traitt: Trait): return modifier + traitt.damage_applied_modifier,
		0
	)
	return MinMax.create(
		max(0, weapon.damage.min_value + damage_modifier),
		max(1, weapon.damage.max_value + damage_modifier)
	)
	
func get_defense() -> int:
	return traits.reduce(
		func(defense, traitt: Trait): return defense - traitt.damage_taken_modifier,
		0
	)

func can_attack(pos: Vector2) -> bool:
	var distance = global_position.distance_to(pos)
	return distance < weapon.reach
	
func attack(oponent: Combatant) -> Attack:
	if not can_attack(oponent.global_position):
		return null
	var damage_min_max = get_damage_min_max()
	var damage = damage_min_max.get_random_value()
	return Attack.new(
		self,
		oponent.global_position,
		damage,
		weapon.effect_radius,
		weapon.speed
	)
	
func take_damage(damage: int) -> void:
	if damage == 0 or not is_alive() or _inmune:
		return
	_inmune = true
	var random_inmune_time_s = _inmune_time_s.get_random_value()
	get_tree().create_timer(random_inmune_time_s).timeout.connect(
		func(): _inmune = false
	)
	var defense = get_defense()
	damage = max(0, damage - defense)
	state_machine.transition_to_state(
		CombatantHitState.get_state_name(), 
		[damage]
	)
