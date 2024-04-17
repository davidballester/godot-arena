extends CharacterBody2D
class_name CombatantController

@onready var view: CombatantView = %CombatantView
@onready var _state_machine: CombatantControllerStateMachine = %StateMachine
@onready var _collision_shape: CollisionShape2D = %CollisionShape2D

var id: String
var weapon: WeaponController
var model: Combatant
var _facing_right: bool = true
var _attacking: bool = false

func initialize(
	model: Combatant,
	team: Team,
	weapon: WeaponController,
	dust_sprite_frames: SpriteFrames
) -> void:
	self.model = model
	self.weapon = weapon
	id = "%s_controller" % model.id
	model.state_machine.state_changed.connect(_on_state_changed)
	model.weapon = weapon.model
	add_child(model)
	view.initialize(model.sprite_frames, dust_sprite_frames, model.health, team)
	view.add_child(weapon)
	_state_machine.initialize()
	_state_machine.transition_to_state(CombatantControllerIdleState.get_state_name())
		
func attack(combatant: Combatant) -> void:
	if _attacking:
		await get_tree().create_timer(0.3).timeout
		return
	_attacking = true
	var weapon_animation_start_time_ms = Time.get_ticks_msec()
	await weapon.attack()
	var weapon_animation_time_ms = Time.get_ticks_msec() - weapon_animation_start_time_ms
	var weapon_animation_time_s = weapon_animation_time_ms / 1e3
	var attack_time_s = model.weapon.attack_duration_s
	var remaining_time_s = attack_time_s - weapon_animation_time_s
	await get_tree().create_timer(remaining_time_s).timeout
	if _state_machine.current_state is CombatantControllerEngageEnemyState:
		var damage = model.attack(combatant.global_position)
		combatant.take_damage(damage)
	_attacking = false
	
func face(pos: Vector2) -> void:
	weapon.face(pos)
	var should_face_right = global_position.x < pos.x
	var should_turn = (should_face_right and not _facing_right) or (not should_face_right and _facing_right)
	if not should_turn:
		return
	_turn()
	
func die() -> void:
	_collision_shape.disabled = true
	await view.die()
		
func _turn() -> void:
	_facing_right = not _facing_right
	weapon.turn()
	view.flip_h = not _facing_right
	await view.turn(true)

func _on_state_changed(state: State) -> void:
	if state is CombatantApproachEnemyState:
		_state_machine.transition_to_state(
			CombatantControllerApproachEnemyState.get_state_name(), 
			[state.combatant_id]
		)
		return
	if state is CombatantHitState:
		_state_machine.transition_to_state(
			CombatantControllerHitState.get_state_name(),
			[state.damage]
		)
		return
	if state is CombatantDeadState:
		_state_machine.transition_to_state(
			CombatantControllerDeadState.get_state_name()
		)
		return
	if state is CombatantEngageEnemyState:
		_state_machine.transition_to_state(
			CombatantControllerEngageEnemyState.get_state_name(),
			[state.combatant]
		)
		return
	if state is CombatantVictoryState:
		_state_machine.transition_to_state(
			CombatantControllerIdleState.get_state_name()
		)
		return
