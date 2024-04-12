extends CharacterBody2D
class_name CombatantController

@export var id: String = "ignotus1234"
@export var team: Team
@export var speed: float = 40.0
@export var battle: Battle
@export var sprite_frames: SpriteFrames
@export var weapon_type: WeaponController.WeaponType
@onready var view: CombatantView = %CombatantView
@onready var model: Combatant = %CombatantModel
@onready var state_machine: CombatantControllerStateMachine = %StateMachine
var facing_right: bool = true
var weapon_view: WeaponView
var attacking: bool = false

func initialize() -> void:
	view.sprite_frames = sprite_frames
	view.health = model.health
	view.initialize()
	model.id = id
	model.team_id = team.id
	model.speed = speed
	model.battle = battle
	model.initialize()
	battle.add_combatant(model)
	model.state_machine.state_changed.connect(_on_state_changed)
	var weapon = WeaponController.load_weapon_model(weapon_type)
	model.weapon = weapon
	model.add_child(weapon)
	weapon_view = WeaponController.load_weapon_view(weapon_type)
	view.add_child(weapon_view)
	weapon_view.position.x = 6
	state_machine.initialize(self)
	state_machine.transition_to_state(CombatantControllerIdleState.get_state_name())
		
func attack(combatant: Combatant) -> void:
	if attacking:
		await get_tree().create_timer(0.3).timeout
		return
	attacking = true
	var weapon_animation_start_time_ms = Time.get_ticks_msec()
	await weapon_view.attack()
	var weapon_animation_time_ms = Time.get_ticks_msec() - weapon_animation_start_time_ms
	var weapon_animation_time_s = weapon_animation_time_ms / 1e3
	var attack_time_s = model.weapon.attack_duration_s
	var remaining_time_s = attack_time_s - weapon_animation_time_s
	await get_tree().create_timer(remaining_time_s).timeout
	if state_machine.current_state is CombatantControllerEngageEnemyState:
		var damage = model.attack(combatant.global_position)
		combatant.take_damage(damage)
	attacking = false
	
func face(pos: Vector2) -> void:
	weapon_view.face_position(pos)
	var should_face_right = global_position.x < pos.x
	var should_turn = (should_face_right and not facing_right) or (not should_face_right and facing_right)
	if not should_turn:
		return
	_turn()
		
func _turn() -> void:
	facing_right = not facing_right
	weapon_view.position.x *= -1
	weapon_view.scale.y *= -1
	view.flip_h = not facing_right
	await view.turn(true)

func _on_state_changed(state: State) -> void:
	if state is CombatantApproachEnemyState:
		state_machine.transition_to_state(
			CombatantControllerApproachEnemyState.get_state_name(), 
			[state.combatant_id]
		)
		return
	if state is CombatantHitState:
		state_machine.transition_to_state(
			CombatantControllerHitState.get_state_name(),
			[state.damage]
		)
		return
	if state is CombatantDeadState:
		state_machine.transition_to_state(
			CombatantControllerDeadState.get_state_name()
		)
		return
	if state is CombatantEngageEnemyState:
		state_machine.transition_to_state(
			CombatantControllerEngageEnemyState.get_state_name(),
			[state.combatant]
		)
		return
	if state is CombatantVictoryState:
		state_machine.transition_to_state(
			CombatantControllerIdleState.get_state_name()
		)
		return
