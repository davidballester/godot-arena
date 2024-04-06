extends Node2D
class_name Combatant

var team_id: String = "adventurers1234"
var state_machine: CombatantStateMachine
@export var id: String = "ignotus1234"
@export var speed: float = 40.0
@export var battle: Battle
@export var weapon: Weapon
@onready var health: Gauge = $Health
@onready var brain: Brain = $Brain
@onready var perception: CombatantPerceptionComponent = $Perception

func initialize() -> void:
	perception.self_combatant = self
	state_machine = CombatantStateMachine.new()
	state_machine.id = id + "_state_machine"
	state_machine.add_child(CombatantApproachEnemyState.new())
	state_machine.add_child(CombatantEngageEnemyState.new())
	state_machine.add_child(CombatantEscapeState.new())
	state_machine.add_child(CombatantSeekEnemyState.new())
	state_machine.add_child(CombatantVictoryState.new())
	state_machine.add_child(CombatantDeadState.new())
	state_machine.add_child(CombatantHitState.new())
	add_child(state_machine)
	state_machine.initialize(self, battle)
	state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())

func is_alive() -> bool:
	return health.current_value > 0

func can_attack(pos: Vector2) -> bool:
	var distance = global_position.distance_to(pos)
	return distance < 30
	
func attack(pos: Vector2) -> int:
	await weapon.wait_attack_duration()
	return weapon.get_damage() if can_attack(pos) else 0
	
func take_damage(damage: int) -> void:
	if not is_alive():
		return
	state_machine.transition_to_state(
		CombatantHitState.get_state_name(), 
		[damage]
	)
