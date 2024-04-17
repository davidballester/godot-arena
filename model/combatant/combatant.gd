extends Node2D
class_name Combatant

var id: String
var type: String
var team_id: String
var speed: float = 40.0
var weapon: Weapon
var brain: Brain
var perception: CombatantPerceptionComponent
var state_machine: CombatantStateMachine
var health: Gauge
var battle: Battle
var sprite_frames: SpriteFrames

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
	perception: CombatantPerceptionComponent,
	health: Gauge,
	sprite_frames: SpriteFrames
) -> void:
	self.id = id
	self.type = type
	self.team_id = team_id
	self.speed = speed
	self.weapon = weapon
	self.brain = brain
	self.perception = perception
	self.health = health
	self.battle = battle
	self.sprite_frames = sprite_frames
	perception.self_combatant = self
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
	state_machine.initialize()
	state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())

func is_alive() -> bool:
	return health.current_value > 0

func can_attack(pos: Vector2) -> bool:
	var distance = global_position.distance_to(pos)
	return distance < weapon.reach
	
func attack(pos: Vector2) -> int:
	return weapon.get_damage() if can_attack(pos) else 0
	
func take_damage(damage: int) -> void:
	if damage == 0 or not is_alive() or _inmune:
		return
	_inmune = true
	var random_inmune_time_s = _inmune_time_s.get_random_value()
	get_tree().create_timer(random_inmune_time_s).timeout.connect(
		func(): _inmune = false
	)
	state_machine.transition_to_state(
		CombatantHitState.get_state_name(), 
		[damage]
	)
